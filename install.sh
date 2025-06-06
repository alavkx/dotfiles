#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from home directory to dotfiles

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(".zshrc" ".gitconfig")
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

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

if [[ -f "$DOTFILES_DIR/.vscode/settings.json" ]]; then
    mkdir -p "$VSCODE_DIR"
    vscode_settings="$VSCODE_DIR/settings.json"
    
    if [[ -L "$vscode_settings" ]]; then
        echo "Removing existing VSCode settings symlink"
        rm "$vscode_settings"
    elif [[ -f "$vscode_settings" ]]; then
        echo "Backing up existing VSCode settings: $vscode_settings -> $vscode_settings.backup"
        mv "$vscode_settings" "$vscode_settings.backup"
    fi
    
    echo "Linking $DOTFILES_DIR/.vscode/settings.json -> $vscode_settings"
    ln -s "$DOTFILES_DIR/.vscode/settings.json" "$vscode_settings"
else
    echo "Warning: .vscode/settings.json not found in dotfiles directory"
fi

if [[ -f "$DOTFILES_DIR/.vscode/extensions.txt" ]]; then
    echo "Installing VSCode extensions..."
    while IFS= read -r extension; do
        if [[ -n "$extension" && ! "$extension" =~ ^[[:space:]]*# ]]; then
            echo "Installing: $extension"
            code --install-extension "$extension" --force
        fi
    done < "$DOTFILES_DIR/.vscode/extensions.txt"
else
    echo "Warning: .vscode/extensions.txt not found in dotfiles directory"
fi

if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
    if command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew packages..."
        brew bundle install --file="$DOTFILES_DIR/Brewfile"
    else
        echo "Warning: Homebrew not found, skipping package installation"
        echo "Install from: https://brew.sh"
    fi
else
    echo "Warning: Brewfile not found in dotfiles directory"
fi

echo "Done! Remember to restart your shell or run 'source ~/.zshrc'" 
