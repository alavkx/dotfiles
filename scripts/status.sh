#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILES=(".zshrc" ".gitconfig")
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
VSCODE_FILES=("settings.json")

check_file_status() {
    local file="$1"
    local target_path="$2"
    local expected_link="$3"
    
    printf "$file: "
    if [[ -L "$target_path" ]]; then
        local actual_link=$(readlink "$target_path")
        if [[ "$actual_link" == "$expected_link" ]]; then
            echo "✅ correctly linked"
        else
            echo "⚠️  linked to $actual_link (not our dotfiles)"
        fi
    elif [[ -f "$target_path" ]]; then
        echo "📄 regular file (not linked)"
    else
        echo "❌ missing"
    fi
}

echo "Dotfiles status:"
for file in "${FILES[@]}"; do
    check_file_status "$file" "$HOME/$file" "$DOTFILES_DIR/$file"
done

echo
echo "VSCode settings:"
for file in "${VSCODE_FILES[@]}"; do
    check_file_status "$file" "$VSCODE_DIR/$file" "$DOTFILES_DIR/.vscode/$file"
done 
