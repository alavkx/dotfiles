#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Exporting Homebrew packages..."
brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force --no-vscode
echo "✅ Packages exported to Brewfile" 
