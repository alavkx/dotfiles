#!/bin/bash

FILES=(".zshrc" ".gitconfig")
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

echo "Cleaning up symlinks..."

for file in "${FILES[@]}"; do
    if [[ -L "$HOME/$file" ]]; then
        echo "Removing symlink: $file"
        rm "$HOME/$file"
        if [[ -f "$HOME/$file.backup" ]]; then
            echo "Restoring from backup: $file"
            mv "$HOME/$file.backup" "$HOME/$file"
        fi
    fi
done

# Clean up VSCode settings symlink
vscode_settings="$VSCODE_DIR/settings.json"
if [[ -L "$vscode_settings" ]]; then
    echo "Removing VSCode settings symlink"
    rm "$vscode_settings"
    if [[ -f "$vscode_settings.backup" ]]; then
        echo "Restoring VSCode settings from backup"
        mv "$vscode_settings.backup" "$vscode_settings"
    fi
fi

echo "✅ Cleanup completed" 
