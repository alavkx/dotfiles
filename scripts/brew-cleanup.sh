#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Cleaning up packages not in Brewfile..."

if [[ ! -f "$BREWFILE" ]]; then
    echo "❌ Brewfile not found"
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not installed"
    exit 1
fi

# Find explicitly installed packages not in Brewfile
INSTALLED_TEMP="/tmp/installed-brew.txt"
BREWFILE_TEMP="/tmp/brewfile-brew.txt"

{
    brew leaves
    brew list --cask 2>/dev/null || true
} | sort > "$INSTALLED_TEMP"

grep -E '^(brew|cask)' "$BREWFILE" | sed 's/^[^"]*"//' | sed 's/".*$//' | sort > "$BREWFILE_TEMP"

ORPHANED_PACKAGES=$(comm -23 "$INSTALLED_TEMP" "$BREWFILE_TEMP")

if [[ -z "$ORPHANED_PACKAGES" ]]; then
    echo "✅ No orphaned packages found"
else
    echo "📦 Found orphaned packages:"
    echo "$ORPHANED_PACKAGES"
    echo
    read -p "Remove these packages? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "$ORPHANED_PACKAGES" | xargs brew uninstall
        echo "✅ Orphaned packages removed"
    else
        echo "❌ Cleanup cancelled"
    fi
fi

# Cleanup temp files
rm -f "$INSTALLED_TEMP" "$BREWFILE_TEMP" 
