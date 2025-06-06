#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"

# Check for quiet flag
if [[ "$1" != "--quiet" ]]; then
    echo "Exporting Homebrew packages..."
fi

brew bundle dump --file="$HOME_FILES_DIR/Brewfile" --force --no-vscode

if [[ "$1" != "--quiet" ]]; then
    echo "✅ Packages exported to home/Brewfile"
fi 
