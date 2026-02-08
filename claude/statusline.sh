#!/bin/bash

# Read JSON input
input=$(cat)

# Debug: Log what we receive to a file
DEBUG_FILE="$HOME/.claude/statusline-debug.log"
echo "=== $(date) ===" >> "$DEBUG_FILE"
echo "Input length: ${#input}" >> "$DEBUG_FILE"
echo "Input content:" >> "$DEBUG_FILE"
echo "$input" >> "$DEBUG_FILE"
echo "" >> "$DEBUG_FILE"

# Validate environment and input
if ! command -v jq &> /dev/null; then
    echo "jq not found"
    exit 1
fi

if [ -z "$input" ]; then
    echo "No input"
    exit 1
fi

if ! echo "$input" | jq empty 2>/dev/null; then
    echo "Invalid JSON"
    exit 1
fi

# Helper function to safely extract fields with fallback values
get_field() {
    local field=$1
    local fallback=$2
    local value=$(echo "$input" | jq -r "$field // empty")

    if [ -z "$value" ] || [ "$value" = "null" ]; then
        echo "$fallback"
    else
        echo "$value"
    fi
}

# Extract basic info with safe fallbacks
cwd=$(get_field '.workspace.current_dir' '~')
if [ "$cwd" = "~" ]; then
    cwd_name="~"
else
    cwd_name=$(basename "$cwd")
fi
model_name=$(get_field '.model.display_name' 'Claude')
context_used=$(get_field '.context_window.used_percentage' '0')

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

# Validate context_used is numeric before using it
if ! [[ "$context_used" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    context_used=0
fi

# Get color for context usage
context_color=$(get_color "$context_used")

# Build status line
printf "\033[0;36m%s\033[0m | \033[1;37m%s\033[0m | Context: \033[%sm%.0f%%\033[0m" \
    "$cwd_name" \
    "$model_name" \
    "$context_color" "$context_used"
