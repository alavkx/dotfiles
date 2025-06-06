# Architecture & Design Limitations

This document outlines the current system's architectural debt and how a production-ready version would differ.

## Current System Coupling Issues

### 1. Hard-Coded Profile Location Coupling

**Problem:** Every script hard-codes the profile location:

```bash
# In every script:
HOME_FILES_DIR="$DOTFILES_DIR/home"
```

**Impact:**

- Profile contents are tightly coupled to tool source code
- Cannot have multiple profiles or profile locations
- Tool and user data live in same repository

**Production Solution:** Configuration-driven profile discovery:

```bash
# Config file: ~/.config/config/config.yml
profiles:
  default: ~/.config-profile
  work: ~/.config-work-profile

# Tool would read config, not hardcode paths
```

### 2. Shell Integration Coupling

**Problem:** User's `.zshrc` contains tool-specific code:

```bash
# In home/.zshrc:
if [[ ! -f ~/.env ]]; then
  echo "EXAMPLE_VAR=\"example_value\"" > ~/.env
fi
source ~/.env

# Plus potential future config-env-set function
```

**Impact:**

- User's shell config is polluted with tool internals
- Breaks if user removes/changes config tool
- No clean separation between user preferences and tool requirements

**Production Solution:** Tool-managed shell hooks:

```bash
# Tool installs single hook in .zshrc:
[[ -f ~/.config/config/shell-hook.sh ]] && source ~/.config/config/shell-hook.sh

# All tool logic lives in tool-managed files
```

### 3. File Structure Assumptions

**Problem:** Scripts assume specific file structure:

- `.zshrc` and `.gitconfig` in profile root
- `.vscode/` subdirectory with exact file names
- `Brewfile` in specific location

**Impact:**

- No flexibility for different profile organizations
- Cannot support users with different preferences
- Hard to extend for new tools

**Production Solution:** Profile manifest:

```yaml
# profile/config.yml
manifest_version: "1.0"
files:
  shell: .zshrc
  git: .gitconfig

tools:
  vscode:
    settings: .vscode/settings.json
    extensions: .vscode/extensions.txt
  homebrew:
    brewfile: Brewfile
```

## Production Architecture Design

### Separation of Concerns

**Current (Mixed):**

```
config/
├── home/           # User profile data
├── scripts/        # Tool source code
├── config          # Tool executable
└── install.sh      # Tool installer
```

**Production (Separated):**

**Tool Installation:**

```bash
# User installs tool globally
brew install config
# or
curl -sSL https://install.config.dev | sh
```

**User Profile Repository:**

```
my-config/
├── config.yml    # Profile manifest
├── .zshrc         # User's shell config
├── .gitconfig     # User's git config
├── .vscode/       # VSCode settings
├── Brewfile       # Homebrew packages
└── README.md      # User's documentation
```

**Tool Configuration:**

```
~/.config/config/
├── config.yml     # Tool configuration
├── profiles.yml   # Profile locations
└── hooks/         # Shell integration
```

### Profile System Design

```bash
# Multiple profiles support
config profile create work --clone-from default
config profile switch work
config profile list

# Flexible profile locations
config profile add ~/work --name work
config profile add ~/personal --name personal
```

## Additional Architectural Issues

### 3. Platform Dependencies

**Problem:** macOS-specific assumptions throughout:

- VSCode path: `~/Library/Application Support/Code/User/`
- `stat -f %m` (BSD stat, not GNU)
- Homebrew assumptions

**Production Solution:** Platform abstraction layer with feature detection.

### 4. Tool Detection Hardcoding

**Problem:** Each tool integration is hardcoded:

```bash
# Hardcoded in brew-*.sh, vscode-*.sh
if command -v brew >/dev/null 2>&1; then
if command -v code >/dev/null 2>&1; then
```

**Production Solution:** Plugin system:

```bash
# plugins/homebrew.yml
name: homebrew
commands: [brew]
files: [Brewfile]
export_cmd: "brew bundle dump --file={file}"
install_cmd: "brew bundle install --file={file}"
```

### 5. Security Considerations

**Problem:** Automatically sources `.env` files without validation:

```bash
source ~/.env  # Could execute arbitrary code
```

**Production Solution:**

- Validate `.env` syntax before sourcing
- Sandbox environment variable loading
- User confirmation for dangerous operations

### 6. No Versioning Strategy

**Problem:** No way to handle:

- Profile format changes
- Tool compatibility
- Migration between versions

**Production Solution:**

- Semantic versioning for profile format
- Migration scripts between versions
- Backwards compatibility guarantees

### 7. Error Handling & Rollback

**Problem:** Limited error handling:

- No atomic operations
- Backups not always created consistently
- No rollback mechanism for failed operations

**Production Solution:**

- Transaction-like operations
- Consistent backup/restore system
- Detailed logging and error recovery

## Migration Path

To move toward production architecture:

1. **Phase 1:** Add configuration file support
2. **Phase 2:** Abstract platform-specific code
3. **Phase 3:** Implement profile system
4. **Phase 4:** Create plugin architecture
5. **Phase 5:** Separate tool from user profiles
6. **Phase 6:** Add security and versioning

## Benefits of Production Architecture

- **User repositories only contain user data**
- **Tool can be installed/updated independently**
- **Support for multiple platforms and tools**
- **Clear separation of concerns**
- **Better security and error handling**
- **Plugin ecosystem for community extensions**

The current system works well for personal use but has significant architectural debt that would need addressing for public distribution.
