#!/bin/bash

set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_codex_cli() {
    echo "📦 Installing Codex CLI..."
    if command_exists codex; then
        echo "✅ Codex CLI is already installed"
    else
        npm install -g @openai/codex
        echo "✅ Codex CLI installed successfully"
    fi
}

install_codex_config() {
    echo "📝 Installing Codex CLI configuration..."
    echo "⚠️ Codex CLI config installation is not yet implemented"
}

install_codex_cli
install_codex_config
