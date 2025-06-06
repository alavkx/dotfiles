#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Installing Homebrew packages..."

if [[ ! -f "$BREWFILE" ]]; then
    echo "❌ Brewfile not found"
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not installed"
    echo "Install from: https://brew.sh"
    exit 1
fi

echo "📦 Installing packages from Brewfile..."
brew bundle install --file="$BREWFILE"
echo "✅ Homebrew packages installation completed" 
