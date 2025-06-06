#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"

echo "Exporting VSCode extensions..."
code --list-extensions > "$HOME_FILES_DIR/.vscode/extensions.txt"
echo "✅ Extensions exported to home/.vscode/extensions.txt" 
