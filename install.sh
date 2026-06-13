#!/bin/bash
#
# Safe to re-run.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up AI development tools..."
echo

for tool_script in "${SCRIPT_DIR}"/*/install.sh; do
    [ -f "$tool_script" ] || continue
    bash "$tool_script"
    echo
done

echo "Installation complete! AI development tools are ready to use"
echo
echo "Available commands:"
echo "  - claude: Claude Code CLI"
echo "  - codex: Codex CLI"
echo "  - copilot: GitHub Copilot CLI"
