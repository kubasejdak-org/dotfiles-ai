#!/bin/bash
#
# Safe to re-run.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_codex_cli() {
    echo "Installing Codex..."
    if command_exists codex; then
        echo "  already installed ($(codex --version))"
    else
        curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 bash
        echo "  installed"
    fi
}

install_codex_config() {
    echo "InstallingCodex configuration..."
    mkdir -p ~/.codex

    ln -sf "${SCRIPT_DIR}/config.toml" ~/.codex/

    # Install shared skills
    mkdir -p ~/.codex/skills
    for entry in "${SCRIPT_DIR}/../skills/"*; do
        ln -sfn "$entry" ~/.codex/skills/
    done
    echo "  installed"
}

install_codex_cli
install_codex_config
