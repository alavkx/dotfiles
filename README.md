# Dotfiles Management System

Personal configuration files managed with automated syncing and installation.

## Structure

```
dotfiles/
├── home/                    # Your actual dotfiles and configurations
│   ├── .zshrc              # Shell configuration
│   ├── .gitconfig          # Git settings
│   ├── .vscode/            # VSCode settings and extensions
│   └── Brewfile            # Homebrew packages
├── scripts/                # Management scripts (project source)
├── config                  # Global command (symlinked to ~/.local/bin/)
├── install.sh              # Installation script
└── Makefile               # Build system with clean API
```

## Quick Start

```bash
make install    # Install all dotfiles
config status   # Check current state (from anywhere!)
```

The `config` command is globally accessible after installation - use it from any directory.

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

## Architecture & Limitations

This system was built for personal use and has architectural debt that would need addressing for production use. See [`ARCHITECTURE.md`](ARCHITECTURE.md) for detailed analysis of:

- **Coupling issues** between tool and profile data
- **Design limitations** in the current approach
- **Production architecture** for open source distribution
- **Migration path** toward better separation of concerns

Key limitation: The `home/` directory is tightly coupled to the tool scripts, and your `.zshrc` contains tool-specific code. A production version would separate the tool installation from user profile data.
