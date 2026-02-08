#!/bin/bash

# Read JSON input
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
cwd_name=$(basename "$cwd")
model_name=$(echo "$input" | jq -r '.model.display_name')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

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

# Get color for context usage
context_color=$(get_color "$context_used")

# Build status line
printf "\033[0;36m%s\033[0m | \033[1;37m%s\033[0m | Context: \033[%sm%.0f%%\033[0m" \
    "$cwd_name" \
    "$model_name" \
    "$context_color" "$context_used"
