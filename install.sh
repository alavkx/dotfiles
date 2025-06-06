#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from home directory to dotfiles

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(".zshrc" ".gitconfig")

link_file() {
    local src="$DOTFILES_DIR/$1"
    local dest="$HOME/$1"
    
    if [[ -L "$dest" ]]; then
        echo "Removing existing symlink: $dest"
        rm "$dest"
    elif [[ -f "$dest" ]]; then
        echo "Backing up existing file: $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi
    
    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
}

echo "Installing dotfiles from $DOTFILES_DIR"

for file in "${FILES[@]}"; do
    if [[ -f "$DOTFILES_DIR/$file" ]]; then
        link_file "$file"
    else
        echo "Warning: $file not found in dotfiles directory"
    fi
done

echo "Done! Remember to restart your shell or run 'source ~/.zshrc'" 
