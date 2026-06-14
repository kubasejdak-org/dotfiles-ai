#!/bin/bash
#
# Safe to re-run.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_copilot_cli() {
    echo "Installing GitHub Copilot..."
    if command_exists copilot; then
        echo "  already installed ($(copilot --version))"
    else
        curl -fsSL https://gh.io/copilot-install | bash
        echo "  installed"
    fi
}

install_copilot_config() {
    echo "Installing GitHub Copilot configuration..."
    ln -sf "${SCRIPT_DIR}/settings.json" ~/.copilot/
    echo "  installed"
}

install_copilot_cli
install_copilot_config
