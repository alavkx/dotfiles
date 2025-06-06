#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"

# Check for quiet flag
if [[ "$1" != "--quiet" ]]; then
    echo "Exporting VSCode extensions..."
fi

code --list-extensions > "$HOME_FILES_DIR/.vscode/extensions.txt"

if [[ "$1" != "--quiet" ]]; then
    echo "✅ Extensions exported to home/.vscode/extensions.txt"
fi 
