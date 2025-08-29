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
        npm install -g @anthropic-ai/claude-code
        echo "✅ Claude Code installed successfully"
    fi
}

install_claude_config() {
    echo "📝 Installing Claude Code configuration..."

    # Remote MCP servers
    claude mcp add --transport http context7 https://mcp.context7.com/mcp || true
    claude mcp add --transport http microsoft-docs https://learn.microsoft.com/api/mcp || true
    claude mcp add --transport http notion https://mcp.notion.com/mcp || true

    # Local MCP servers
    FILESYSTEM_PATHS=""
    for path in ~/Downloads ~/nas ~/projects /tmp; do
        if [ -d "$path" ]; then
            FILESYSTEM_PATHS="$FILESYSTEM_PATHS $path"
        fi
    done
    
    if [ -n "$FILESYSTEM_PATHS" ]; then
        claude mcp add filesystem npx @modelcontextprotocol/server-filesystem$FILESYSTEM_PATHS || true
    fi
    claude mcp add puppeteer npx @modelcontextprotocol/server-puppeteer || true
    claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant || true

    # Install configs
    ln -sf "${SCRIPT_DIR}/agents" ~/.claude
    ln -sf "${SCRIPT_DIR}/CLAUDE.md" ~/.claude
    ln -sf "${SCRIPT_DIR}/commands" ~/.claude
    ln -sf "${SCRIPT_DIR}/settings.json" ~/.claude
    ln -sf "${SCRIPT_DIR}/shared" ~/.claude
}

install_claude_code
install_claude_config
