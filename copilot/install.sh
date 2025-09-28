#!/bin/bash

set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_copilot_cli() {
    echo "📦 Installing GitHub Copilot CLI..."
    if command_exists copilot; then
        echo "✅ GitHub Copilot CLI is already installed"
    else
        npm install -g @github/copilot
        echo "✅ GitHub Copilot CLI installed successfully"
    fi
}

install_copilot_config() {
    echo "📝 Installing GitHub Copilot CLI configuration..."
    echo "⚠️ GitHub Copilot CLI config installation is not yet implemented"
}

install_copilot_cli
install_copilot_config
