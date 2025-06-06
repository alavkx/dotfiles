# Dotfiles

Personal configuration files managed via symlinks.

## Quick Start

```bash
make install    # Install all dotfiles
make status     # Check current state
```

## Files

- `.zshrc` - Shell configuration with git aliases and environment setup
- `.gitconfig` - Git configuration
- `.vscode/` - VSCode settings and extensions

## Usage

**Core Commands:**

- `make install` - Install dotfiles and VSCode extensions
- `make status` - Show current symlink status
- `make test` - Run full test suite
- `make verify` - Verify all links are correct

**Maintenance:**

- `make backup` - Create timestamped backups
- `make clean` - Remove symlinks and restore backups

**VSCode:**

- `make vscode-export` - Export current extensions
- `make vscode-install` - Install extensions from list
- `make vscode-diff` - Compare installed vs dotfiles
