#!/bin/bash

set -e

echo "🚀 Installing AI development tools..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_nodejs() {
    echo "📦 Installing Node.js..."

    if command_exists node && command_exists npm; then
        echo "✅ Node.js $(node --version) and npm $(npm --version) are already installed"
    else
        echo "Installing Node.js via nvm..."

        # Install nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

        # Source nvm for current session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        npm install -g npm@latest

        echo "✅ Node.js $(node --version) and npm $(npm --version) installed successfully"
    fi
}

install_claude() {
    echo "📦 Installing Claude Code..."
    if command_exists claude; then
        echo "✅ Claude Code is already installed ($(claude --version))"
    else
        npm install -g @anthropic-ai/claude-code
        echo "✅ Claude Code installed successfully"
    fi
}

install_gemini() {
    echo "📦 Installing Gemini CLI..."
    if command_exists gemini; then
        echo "✅ Gemini CLI is already installed"
    else
        npm install -g @google/gemini-cli
        echo "✅ Gemini CLI installed successfully"
    fi
}

install_claude_config() {
    echo "📝 Installing Claude Code configuration..."

    # Remote MCP servers
    claude mcp add --transport http context7 https://mcp.context7.com/mcp || true
    claude mcp add --transport http microsoft-docs https://learn.microsoft.com/api/mcp || true
    claude mcp add --transport http notion https://mcp.notion.com/mcp || true

    # Local MCP servers
    claude mcp add filesystem npx @modelcontextprotocol/server-filesystem ~/Downloads ~/nas ~/projects /tmp || true
    claude mcp add puppeteer npx @modelcontextprotocol/server-puppeteer || true

    # Install configs
    ln -sf "${SCRIPT_DIR}/claude/agents" ~/.claude
    ln -sf "${SCRIPT_DIR}/claude/CLAUDE.md" ~/.claude
    ln -sf "${SCRIPT_DIR}/claude/commands" ~/.claude
    ln -sf "${SCRIPT_DIR}/claude/settings.json" ~/.claude
    ln -sf "${SCRIPT_DIR}/claude/shared" ~/.claude
}

install_gemini_config() {
    echo "📝 Installing Gemini CLI configuration..."
    echo "⚠️ Gemini CLI config installation is not yet implemented"
}

install_nodejs

install_claude
install_claude_config

install_gemini
install_gemini_config

echo "🎉 Installation complete! AI development tools are ready to use."
echo ""
echo "Available commands:"
echo "  - claude: Claude Code"
echo "  - gemini: Gemini CLI"
echo ""
