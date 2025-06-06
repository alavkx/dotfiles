#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Exporting VSCode extensions..."
code --list-extensions > "$DOTFILES_DIR/.vscode/extensions.txt"
echo "✅ Extensions exported to .vscode/extensions.txt" 
