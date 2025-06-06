#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILES=(".zshrc" ".gitconfig")
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
VSCODE_FILES=("settings.json")

echo "Verifying dotfiles installation..."

all_good=true

for file in "${FILES[@]}"; do
    if [[ ! -L "$HOME/$file" ]] || [[ "$(readlink "$HOME/$file")" != "$DOTFILES_DIR/$file" ]]; then
        echo "❌ $file is not properly linked"
        all_good=false
    fi
done

for file in "${VSCODE_FILES[@]}"; do
    vscode_file="$VSCODE_DIR/$file"
    if [[ ! -L "$vscode_file" ]] || [[ "$(readlink "$vscode_file")" != "$DOTFILES_DIR/.vscode/$file" ]]; then
        echo "❌ VSCode $file is not properly linked"
        all_good=false
    fi
done

if $all_good; then
    echo "✅ All dotfiles are properly linked"
    exit 0
else
    echo "❌ Some dotfiles are not properly linked"
    exit 1
fi 
