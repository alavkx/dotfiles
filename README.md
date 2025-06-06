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

- `make install` - Install dotfiles and extensions
- `make status` - Show current symlink status
- `make sync` - Export current state to dotfiles
- `make diff` - Show what needs syncing

**Maintenance:**

- `make test` - Run full test suite
- `make verify` - Verify all links are correct
- `make backup` - Create timestamped backups
- `make clean` - Remove symlinks and restore backups

## Sync Workflow

When you install new extensions or change settings:

```bash
make sync          # Export current state to dotfiles
git add -A         # Stage changes
git commit -m "Update extensions"
git push           # Sync to GitHub
```

On other machines:

```bash
git pull           # Get latest dotfiles
make install       # Install new extensions/settings
```
