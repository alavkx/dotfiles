#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Syncing current state to dotfiles..."

# Export VSCode extensions
if command -v code >/dev/null 2>&1; then
    echo "📦 Exporting VSCode extensions..."
    "$SCRIPT_DIR/vscode-export.sh"
else
    echo "⚠️  VSCode not found, skipping extension export"
fi

# Future: Add other sync operations here
# - Brew packages
# - System preferences
# - Other tool configurations

echo "✅ Sync completed" 
