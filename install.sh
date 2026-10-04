#!/bin/bash
#
# Safe to re-run.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up AI development tools..."
echo

bash "${SCRIPT_DIR}/claude/install.sh"
echo

bash "${SCRIPT_DIR}/codex/install.sh"
echo

bash "${SCRIPT_DIR}/copilot/install.sh"
echo

echo "Installation complete! AI development tools are ready to use"
echo
echo "Available commands:"
echo "  - claude: Claude Code CLI"
echo "  - codex: Codex CLI"
echo "  - copilot: GitHub Copilot CLI"
