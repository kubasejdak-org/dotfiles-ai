#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_claude_code() {
    echo "📦 Installing Claude Code..."
    if command_exists claude; then
        echo "✅ Claude Code is already installed ($(claude --version))"
    else
        curl -fsSL https://claude.ai/install.sh | bash
        echo "✅ Claude Code installed successfully"
    fi
}

install_claude_config() {
    echo "📝 Installing Claude Code configuration..."

    claude plugin marketplace add anthropics/claude-plugins-official

    # Remote MCP servers
    claude plugin install context7@claude-plugins-official

    # Local MCP servers
    
    # Install configs
    ln -sf "${SCRIPT_DIR}/agents" ~/.claude
    ln -sf "${SCRIPT_DIR}/CLAUDE.md" ~/.claude
    ln -sf "${SCRIPT_DIR}/commands" ~/.claude
    ln -sf "${SCRIPT_DIR}/settings.json" ~/.claude
    ln -sf "${SCRIPT_DIR}/shared" ~/.claude
    ln -sf "${SCRIPT_DIR}/statusline.sh" ~/.claude
}

install_claude_code
install_claude_config
