#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Cleaning up packages not managed by dotfiles..."

# Cleanup Homebrew packages
if command -v brew >/dev/null 2>&1; then
    echo "🍺 Checking Homebrew packages..."
    "$SCRIPT_DIR/brew-cleanup.sh"
    echo
else
    echo "⚠️  Homebrew not found, skipping package cleanup"
    echo
fi

# Future: Add other cleanup operations here
# - VSCode extensions not in extensions.txt
# - System preferences
# - Other tool configurations

echo "✅ Cleanup completed" 
