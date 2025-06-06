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

## Usage

| Command        | Purpose                              |
| -------------- | ------------------------------------ |
| `make install` | Create symlinks from `~` to dotfiles |
| `make test`    | Run full test suite                  |
| `make status`  | Show symlink status                  |
| `make verify`  | Validate installation                |
| `make backup`  | Create timestamped backups           |
| `make clean`   | Remove symlinks, restore backups     |
