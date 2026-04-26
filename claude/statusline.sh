#!/bin/bash

# Read JSON input
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
cwd_name=$(basename "$cwd")
model_name=$(echo "$input" | jq -r '.model.display_name')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Extract rate limit info (only present for subscribers after first API response)
five_hour_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Get git branch if in a git repo
branch_name=""
if [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch_name=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi

# Function to get color based on percentage
get_color() {
    local percent=$1
    local value=$(echo "$percent" | cut -d'.' -f1)  # Get integer part

    if [ "$value" -le 50 ]; then
        echo "1;32"  # Bold Green
    elif [ "$value" -le 80 ]; then
        echo "1;33"  # Bold Yellow
    else
        echo "1;31"  # Bold Red
    fi
}

# Function to get model color based on model name
get_model_color() {
    local model=$1
    if echo "$model" | grep -iq "haiku"; then
        echo "1;34"  # Bold Blue
    elif echo "$model" | grep -iq "sonnet"; then
        echo "1;32"  # Bold Green
    elif echo "$model" | grep -iq "opus"; then
        echo "1;38;5;208"  # Bold Orange
    else
        echo "1;37"  # Bold White (default)
    fi
}

# Function to format time remaining from an ISO timestamp to now
format_time_remaining() {
    local reset_time="$1"
    [ -z "$reset_time" ] && echo "" && return
    local now reset diff
    now=$(date +%s)
    # resets_at is a Unix epoch integer; ISO strings are also supported as fallback
    if [[ "$reset_time" =~ ^[0-9]+$ ]]; then
        reset="$reset_time"
    else
        reset=$(date -d "$reset_time" +%s 2>/dev/null) || { echo ""; return; }
    fi
    diff=$((reset - now))
    [ "$diff" -le 0 ] && echo "now" && return
    local days=$(( diff / 86400 ))
    local hours=$(( (diff % 86400) / 3600 ))
    local minutes=$(( (diff % 3600) / 60 ))
    if [ "$days" -gt 0 ]; then
        echo "${days}d ${hours}h"
    elif [ "$hours" -gt 0 ]; then
        echo "${hours}h ${minutes}m"
    else
        echo "${minutes}m"
    fi
}

# Get color for context usage
context_color=$(get_color "$context_used")

# Get color for model name
model_color=$(get_model_color "$model_name")

# Build rate limit segment
rate_limit_segment=""

if [ -n "$five_hour_used" ]; then
    fh_color=$(get_color "$five_hour_used")
    fh_int=$(printf "%.0f" "$five_hour_used")
    if [ "$fh_int" -eq 0 ]; then
        fh_part=$(printf " | 5h: \033[%sm%d%%\033[0m \033[2m(full)\033[0m" "$fh_color" "$fh_int")
    else
        fh_time=$(format_time_remaining "$five_hour_reset")
        if [ -n "$fh_time" ]; then
            fh_part=$(printf " | 5h: \033[%sm%d%%\033[0m \033[2m(%s)\033[0m" "$fh_color" "$fh_int" "$fh_time")
        else
            fh_part=$(printf " | 5h: \033[%sm%d%%\033[0m" "$fh_color" "$fh_int")
        fi
    fi
    rate_limit_segment="${rate_limit_segment}${fh_part}"
fi

if [ -n "$seven_day_used" ]; then
    sd_color=$(get_color "$seven_day_used")
    sd_int=$(printf "%.0f" "$seven_day_used")
    if [ "$sd_int" -eq 0 ]; then
        sd_part=$(printf " | 7d: \033[%sm%d%%\033[0m \033[2m(full)\033[0m" "$sd_color" "$sd_int")
    else
        sd_time=$(format_time_remaining "$seven_day_reset")
        if [ -n "$sd_time" ]; then
            sd_part=$(printf " | 7d: \033[%sm%d%%\033[0m \033[2m(%s)\033[0m" "$sd_color" "$sd_int" "$sd_time")
        else
            sd_part=$(printf " | 7d: \033[%sm%d%%\033[0m" "$sd_color" "$sd_int")
        fi
    fi
    rate_limit_segment="${rate_limit_segment}${sd_part}"
fi

# Build status line
if [ -n "$branch_name" ]; then
    # Include git branch in status line
    printf "\033[1;37m%s\033[0m | \033[1;33m%s\033[0m | \033[%sm%s\033[0m | Context: \033[%sm%.0f%%\033[0m%s" \
        "$cwd_name" \
        "$branch_name" \
        "$model_color" "$model_name" \
        "$context_color" "$context_used" \
        "$rate_limit_segment"
else
    # No git branch, use original format
    printf "\033[1;37m%s\033[0m | \033[%sm%s\033[0m | Context: \033[%sm%.0f%%\033[0m%s" \
        "$cwd_name" \
        "$model_color" "$model_name" \
        "$context_color" "$context_used" \
        "$rate_limit_segment"
fi
