#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"

echo "Exporting Homebrew packages..."
brew bundle dump --file="$HOME_FILES_DIR/Brewfile" --force --no-vscode
echo "✅ Packages exported to home/Brewfile" 
