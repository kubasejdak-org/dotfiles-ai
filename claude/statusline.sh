#!/bin/bash

# Read JSON input
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Function to get color based on percentage
get_color() {
    local percent=$1
    local value=$(echo "$percent" | cut -d'.' -f1)  # Get integer part
    
    if [ "$value" -le 50 ]; then
        echo "32"  # Green
    elif [ "$value" -le 80 ]; then
        echo "33"  # Yellow
    else
        echo "31"  # Red
    fi
}

# Function to format date from ISO string
format_reset_date() {
    local iso_date=$1
    if [ -z "$iso_date" ] || [ "$iso_date" = "null" ]; then
        echo "N/A"
    else
        date -d "$iso_date" "+%H:%M %d.%m.%Y" 2>/dev/null || echo "N/A"
    fi
}

# Get usage data from Claude API
get_usage_data() {
    local config_file="$HOME/.claude/config.json"
    
    if [ ! -f "$config_file" ]; then
        echo "0|N/A|0|N/A"
        return
    fi
    
    local api_key=$(jq -r '.apiKey // empty' "$config_file" 2>/dev/null)
    
    if [ -z "$api_key" ]; then
        echo "0|N/A|0|N/A"
        return
    fi
    
    local response=$(curl -s -H "x-api-key: $api_key" -H "anthropic-version: 2023-06-01" \
        "https://api.anthropic.com/v1/organization/usage" 2>/dev/null)
    
    if [ -z "$response" ]; then
        echo "0|N/A|0|N/A"
        return
    fi
    
    # Extract session and weekly usage
    local session_limit=$(echo "$response" | jq -r '.limits.session.limit // 0')
    local session_used=$(echo "$response" | jq -r '.limits.session.used // 0')
    local session_reset=$(echo "$response" | jq -r '.limits.session.reset_at // null')
    
    local weekly_limit=$(echo "$response" | jq -r '.limits.weekly.limit // 0')
    local weekly_used=$(echo "$response" | jq -r '.limits.weekly.used // 0')
    local weekly_reset=$(echo "$response" | jq -r '.limits.weekly.reset_at // null')
    
    # Calculate percentages
    local session_percent=0
    if [ "$session_limit" -gt 0 ]; then
        session_percent=$(echo "scale=1; ($session_used / $session_limit) * 100" | bc 2>/dev/null || echo "0")
    fi
    
    local weekly_percent=0
    if [ "$weekly_limit" -gt 0 ]; then
        weekly_percent=$(echo "scale=1; ($weekly_used / $weekly_limit) * 100" | bc 2>/dev/null || echo "0")
    fi
    
    # Format reset dates
    local session_reset_fmt=$(format_reset_date "$session_reset")
    local weekly_reset_fmt=$(format_reset_date "$weekly_reset")
    
    echo "${session_percent}|${session_reset_fmt}|${weekly_percent}|${weekly_reset_fmt}"
}

# Get usage data
usage_data=$(get_usage_data)
session_percent=$(echo "$usage_data" | cut -d'|' -f1)
session_reset=$(echo "$usage_data" | cut -d'|' -f2)
weekly_percent=$(echo "$usage_data" | cut -d'|' -f3)
weekly_reset=$(echo "$usage_data" | cut -d'|' -f4)

# Get colors for percentages
context_color=$(get_color "$context_used")
session_color=$(get_color "$session_percent")
weekly_color=$(get_color "$weekly_percent")

# Build status line
printf "%s | \033[1;37m%s\033[0m | Context: \033[%sm%.1f%%\033[0m | Session: \033[%sm%.1f%%\033[0m (reset: %s) | Weekly: \033[%sm%.1f%%\033[0m (reset: %s)" \
    "$cwd" \
    "$model_name" \
    "$context_color" "$context_used" \
    "$session_color" "$session_percent" "$session_reset" \
    "$weekly_color" "$weekly_percent" "$weekly_reset"
