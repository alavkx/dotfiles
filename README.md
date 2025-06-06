# Dotfiles Management System

**Opinionated, automated development environment management.**

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

**Workflow Commands:**

- `config install` - Install everything from dotfiles to new machine
- `config sync` - Export current state + commit + push (full sync)
- `config pull` - Export current state to dotfiles (no git operations)
- `config diff` - Show what needs syncing
- `config status` - Show current symlink status

**Maintenance:**

- `config test` - Run full test suite
- `config verify` - Verify all links are correct
- `config backup` - Create timestamped backups
- `config clean` - Remove symlinks and restore backups
- `config cleanup` - Remove unmanaged packages

> **Note:** Use `make <command>` when in the dotfiles directory, or `config <command>` from anywhere.

## Opinionated Workflow

**The tool handles the full workflow automatically:**

### Daily Usage

```bash
# After installing packages, extensions, or changing settings:
config sync        # Exports state + commits + pushes automatically
```

### New Machine Setup

```bash
git clone your-dotfiles-repo
cd your-dotfiles
make install       # Installs everything
```

### On Other Machines

```bash
git pull           # Get latest changes
config install     # Install new packages/extensions/settings
```

**Why Opinionated?** You shouldn't waste time on dotfiles maintenance. This tool makes decisions for you:

- Automatic commit messages with timestamps
- Standardized file structure
- Integrated git operations
- One command does everything

> **For Power Users:** Use `config pull` if you want to export state without git operations (e.g., to review changes before committing)

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
