#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Checking sync status..."
echo

# Check VSCode extensions
if command -v code >/dev/null 2>&1; then
    echo "📦 VSCode Extensions:"
    "$SCRIPT_DIR/vscode-diff.sh" | grep -v "Comparing installed vs dotfiles extensions..."
    echo
else
    echo "⚠️  VSCode not found, skipping extension diff"
    echo
fi

# Check Homebrew packages
if command -v brew >/dev/null 2>&1; then
    echo "🍺 Homebrew Packages:"
    "$SCRIPT_DIR/brew-diff.sh" | grep -v "Comparing installed vs Brewfile packages..."
    echo
else
    echo "⚠️  Homebrew not found, skipping package diff"
    echo
fi

# Check dotfiles symlinks
echo "🔗 Dotfiles Links:"
"$SCRIPT_DIR/status.sh" | grep -E "(❌|⚠️|📄)" || echo "✅ All dotfiles properly linked"
echo

# Future: Add other diff checks here
# - System preferences differences
# - Other tool configurations 
