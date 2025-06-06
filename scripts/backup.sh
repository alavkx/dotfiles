#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILES=(".zshrc" ".gitconfig")
BACKUP_DIR="$DOTFILES_DIR/backups/$(date +%Y%m%d_%H%M%S)"

echo "Creating backup of existing dotfiles..."
mkdir -p "$BACKUP_DIR"

for file in "${FILES[@]}"; do
    if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
        echo "Backing up $file"
        cp "$HOME/$file" "$BACKUP_DIR/$file"
    fi
done

echo "✅ Backup created in $BACKUP_DIR" 
