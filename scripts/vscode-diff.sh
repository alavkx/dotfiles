#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXTENSIONS_FILE="$DOTFILES_DIR/.vscode/extensions.txt"

echo "Comparing installed vs dotfiles extensions..."

# Create temporary files for comparison
INSTALLED_TEMP="/tmp/installed-extensions.txt"
DOTFILES_TEMP="/tmp/dotfiles-extensions.txt"

code --list-extensions | sort > "$INSTALLED_TEMP"

if [[ -f "$EXTENSIONS_FILE" ]]; then
    sort "$EXTENSIONS_FILE" > "$DOTFILES_TEMP"
else
    touch "$DOTFILES_TEMP"
fi

echo "Extensions in dotfiles but not installed:"
comm -23 "$DOTFILES_TEMP" "$INSTALLED_TEMP" || true

echo "Extensions installed but not in dotfiles:"
comm -13 "$DOTFILES_TEMP" "$INSTALLED_TEMP" || true

# Cleanup
rm -f "$INSTALLED_TEMP" "$DOTFILES_TEMP" 
