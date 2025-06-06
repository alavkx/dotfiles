#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Comparing installed vs Brewfile packages..."

if [[ ! -f "$BREWFILE" ]]; then
    echo "❌ Brewfile not found"
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not installed"
    exit 1
fi

# Check if Brewfile packages are installed
echo "Packages in Brewfile but not installed:"
brew bundle check --file="$BREWFILE" 2>/dev/null || true

echo
echo "Explicitly installed packages not in Brewfile:"
# Create temporary files for comparison
INSTALLED_TEMP="/tmp/installed-brew.txt"
BREWFILE_TEMP="/tmp/brewfile-brew.txt"

# Extract only explicitly installed packages (not dependencies)
{
    brew leaves              # Top-level formulae 
    brew list --cask 2>/dev/null || true  # All casks (no dependency concept)
} | sort > "$INSTALLED_TEMP"

# Extract packages from Brewfile (skip taps and vscode)
grep -E '^(brew|cask)' "$BREWFILE" | sed 's/^[^"]*"//' | sed 's/".*$//' | sort > "$BREWFILE_TEMP"

# Show explicitly installed packages not in Brewfile
comm -23 "$INSTALLED_TEMP" "$BREWFILE_TEMP" || true

# Cleanup
rm -f "$INSTALLED_TEMP" "$BREWFILE_TEMP" 
