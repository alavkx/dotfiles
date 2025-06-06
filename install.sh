#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from home directory to dotfiles

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_FILES_DIR="$DOTFILES_DIR/home"
FILES=(".zshrc" ".gitconfig")
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

link_file() {
    local src="$HOME_FILES_DIR/$1"
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
    if [[ -f "$HOME_FILES_DIR/$file" ]]; then
        link_file "$file"
    else
        echo "Warning: $file not found in home directory"
    fi
done

if [[ -f "$HOME_FILES_DIR/.vscode/settings.json" ]]; then
    mkdir -p "$VSCODE_DIR"
    vscode_settings="$VSCODE_DIR/settings.json"
    
    if [[ -L "$vscode_settings" ]]; then
        echo "Removing existing VSCode settings symlink"
        rm "$vscode_settings"
    elif [[ -f "$vscode_settings" ]]; then
        echo "Backing up existing VSCode settings: $vscode_settings -> $vscode_settings.backup"
        mv "$vscode_settings" "$vscode_settings.backup"
    fi
    
    echo "Linking $HOME_FILES_DIR/.vscode/settings.json -> $vscode_settings"
    ln -s "$HOME_FILES_DIR/.vscode/settings.json" "$vscode_settings"
else
    echo "Warning: .vscode/settings.json not found in home directory"
fi

if [[ -f "$HOME_FILES_DIR/.vscode/extensions.txt" ]]; then
    echo "Installing VSCode extensions..."
    while IFS= read -r extension; do
        if [[ -n "$extension" && ! "$extension" =~ ^[[:space:]]*# ]]; then
            echo "Installing: $extension"
            code --install-extension "$extension" --force
        fi
    done < "$HOME_FILES_DIR/.vscode/extensions.txt"
else
    echo "Warning: .vscode/extensions.txt not found in home directory"
fi

if [[ -f "$HOME_FILES_DIR/Brewfile" ]]; then
    if command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew packages..."
        brew bundle install --file="$HOME_FILES_DIR/Brewfile"
    else
        echo "Warning: Homebrew not found, skipping package installation"
        echo "Install from: https://brew.sh"
    fi
else
    echo "Warning: Brewfile not found in home directory"
fi

# Set up global config command
setup_global_config() {
    local config_script="$DOTFILES_DIR/config"
    local target_dir="$HOME/.local/bin"
    local target_path="$target_dir/config"
    
    if [[ -f "$config_script" ]]; then
        mkdir -p "$target_dir"
        
        if [[ -L "$target_path" ]]; then
            echo "Updating global config command symlink"
            rm "$target_path"
        elif [[ -f "$target_path" ]]; then
            echo "Backing up existing config command: $target_path -> $target_path.backup"
            mv "$target_path" "$target_path.backup"
        fi
        
        echo "Linking global config command: $config_script -> $target_path"
        ln -s "$config_script" "$target_path"
        
        # Store dotfiles path for the config command
        echo "$DOTFILES_DIR" > "$HOME/.dotfiles_path"
        
        # Check if ~/.local/bin is in PATH
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            echo "⚠️  Add ~/.local/bin to your PATH to use 'config' globally"
            echo "   Add this to your shell config: export PATH=\"\$HOME/.local/bin:\$PATH\""
        fi
    fi
}

setup_global_config

echo "Done! Remember to restart your shell or run 'source ~/.zshrc'"
echo "You can now use 'config <command>' from anywhere (if ~/.local/bin is in PATH)" 
