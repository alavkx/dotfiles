#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"
EXTENSIONS_FILE="$HOME_FILES_DIR/.vscode/extensions.txt"

echo "Installing VSCode extensions..."

if [[ ! -f "$EXTENSIONS_FILE" ]]; then
    echo "❌ home/.vscode/extensions.txt not found"
    exit 1
fi

while IFS= read -r ext; do
    if [[ -n "$ext" && ! "$ext" =~ ^[[:space:]]*# ]]; then
        echo "Installing: $ext"
        code --install-extension "$ext" --force
    fi
done < "$EXTENSIONS_FILE"

echo "✅ Extensions installation completed" 
