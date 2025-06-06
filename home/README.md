# User Profile Files

This directory contains your actual dotfiles and user profile configuration:

## Shell Configuration

- `.zshrc` - Zsh shell configuration and aliases
- `.gitconfig` - Git user settings and aliases

## VSCode Configuration

- `.vscode/settings.json` - VSCode editor settings
- `.vscode/extensions.txt` - List of installed VSCode extensions

## Development Tools

- `Brewfile` - Homebrew packages and applications

## How It Works

These files are symlinked to their proper locations in your home directory:

- `~/.zshrc` → `home/.zshrc`
- `~/.gitconfig` → `home/.gitconfig`
- `~/Library/Application Support/Code/User/settings.json` → `home/.vscode/settings.json`

The `Brewfile` and `extensions.txt` are used to install packages and extensions via CLI tools rather than symlinking.
