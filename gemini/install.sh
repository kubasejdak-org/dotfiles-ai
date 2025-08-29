#!/bin/bash

set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_gemini_cli() {
    echo "📦 Installing Gemini CLI..."
    if command_exists gemini; then
        echo "✅ Gemini CLI is already installed"
    else
        npm install -g @google/gemini-cli
        echo "✅ Gemini CLI installed successfully"
    fi
}

install_gemini_config() {
    echo "📝 Installing Gemini CLI configuration..."
    echo "⚠️ Gemini CLI config installation is not yet implemented"
}

install_gemini_cli
install_gemini_config
