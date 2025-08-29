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

install_nodejs

${SCRIPT_DIR}/claude/install.sh
${SCRIPT_DIR}/gemini/install.sh

echo "🎉 Installation complete! AI development tools are ready to use."
echo ""
echo "Available commands:"
echo "  - claude: Claude Code"
echo "  - gemini: Gemini CLI"
echo ""
