# Dotfiles

Personal configuration files managed via symlinks.

## Quick Start

```bash
make install    # Install all dotfiles
config status   # Check current state (from anywhere!)
```

The `config` command is globally accessible after installation - use it from any directory.

## Files

- `.zshrc` - Shell configuration with git aliases and environment setup
- `.gitconfig` - Git configuration
- `.vscode/` - VSCode settings and extensions
- `Brewfile` - Homebrew packages and apps

## Usage

**Core Commands:**

- `config install` - Install dotfiles and extensions
- `config status` - Show current symlink status
- `config sync` - Export current state to dotfiles
- `config diff` - Show what needs syncing

**Maintenance:**

- `config test` - Run full test suite
- `config verify` - Verify all links are correct
- `config backup` - Create timestamped backups
- `config clean` - Remove symlinks and restore backups
- `config cleanup` - Remove unmanaged packages

> **Note:** Use `make <command>` when in the dotfiles directory, or `config <command>` from anywhere.

## Sync Workflow

When you install new packages, extensions, or change settings:

```bash
config sync        # Export current state to dotfiles
git add -A         # Stage changes
git commit -m "Update packages and extensions"
git push           # Sync to GitHub
```

On other machines:

```bash
git pull           # Get latest dotfiles
config install     # Install new packages/extensions/settings
```

## Cleanup

Remove packages not managed by dotfiles:

```bash
config cleanup     # Interactive removal of unmanaged packages
```
