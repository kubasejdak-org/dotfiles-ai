#!/bin/bash
#
# Safe to re-run.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_claude_cli() {
    echo "Installing Claude Code..."
    if command_exists claude; then
        echo "  already installed ($(claude --version))"
    else
        curl -fsSL https://claude.ai/install.sh | bash
        echo "  installed"
    fi
}

install_claude_config() {
    echo "Installing Claude Code configuration..."

    claude plugin marketplace add anthropics/claude-plugins-official
    claude plugin install clangd-lsp@claude-plugins-official
    claude plugin install pyright-lsp@claude-plugins-official

    # Remote MCP servers
    claude plugin install context7@claude-plugins-official

    # Local MCP servers

    # Install configs
    ln -sf "${SCRIPT_DIR}/CLAUDE.md" ~/.claude/CLAUDE.md
    ln -sf "${SCRIPT_DIR}/settings.json" ~/.claude/settings.json
    ln -sf "${SCRIPT_DIR}/statusline.sh" ~/.claude/statusline.sh

    # Install agents
    mkdir -p ~/.claude/agents
    for entry in "${SCRIPT_DIR}/agents/"*; do
        ln -sf "$entry" ~/.claude/agents/
    done

    # Install commands
    mkdir -p ~/.claude/commands
    for entry in "${SCRIPT_DIR}/commands/"*; do
        ln -sf "$entry" ~/.claude/commands/
    done

    # Install skills
    mkdir -p ~/.claude/skills
    for entry in "${SCRIPT_DIR}/skills/"*; do
        ln -sf "$entry" ~/.claude/skills/
    done

    # Install shared
    mkdir -p ~/.claude/shared
    for entry in "${SCRIPT_DIR}/shared/"*; do
        ln -sf "$entry" ~/.claude/shared/
    done
}

install_claude_cli
install_claude_config
