#!/bin/bash

set -e

echo "🚀 Installing AI development tools..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Node.js using nvm (recommended method)
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

# Function to install Claude Code
install_claude() {
    echo "📦 Installing Claude Code..."
    if command_exists claude; then
        echo "✅ Claude Code is already installed ($(claude --version))"
    else
        npm install -g @anthropic-ai/claude-code
        echo "✅ Claude Code installed successfully"
    fi
}

# Function to install Gemini CLI
install_gemini() {
    echo "📦 Installing Gemini CLI..."
    if command_exists gemini; then
        echo "✅ Gemini CLI is already installed"
    else
        npm install -g @google/gemini-cli
        echo "✅ Gemini CLI installed successfully"
    fi
}

# Function to install Claude Code configuration
install_claude_config() {
    echo "📝 Installing Claude Code configuration..."
    echo "⚠️  Claude Code config installation is not yet implemented"
    echo "    This will create symbolic links for:"
    echo "    - CLAUDE.md -> ~/.config/claude/CLAUDE.md"
    echo "    - Other Claude-specific configurations"
}

# Function to install Gemini CLI configuration
install_gemini_config() {
    echo "📝 Installing Gemini CLI configuration..."
    echo "⚠️  Gemini CLI config installation is not yet implemented"
    echo "    This will create symbolic links for:"
    echo "    - GEMINI.md -> ~/.config/gemini/GEMINI.md"
    echo "    - Other Gemini-specific configurations"
}

# Install Node.js
install_nodejs

# Install AI tools and their configurations
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
echo "Next steps:"
echo "  1. Run 'claude auth' to authenticate with Claude"
echo "  2. Run 'gemini auth' to authenticate with Gemini"
echo "  3. Configure your AI tools as needed"
