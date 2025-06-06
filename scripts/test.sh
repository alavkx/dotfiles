#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Testing dotfiles installation..."

echo "Current symlink status:"
"$SCRIPT_DIR/status.sh"

echo
echo "Testing backup functionality..."

# Save current state
cp ~/.zshrc ~/.zshrc.test-backup 2>/dev/null || true

# Create test file
echo "# test file for makefile" > ~/.zshrc.test
mv ~/.zshrc.test ~/.zshrc

echo "Created test file, running install..."
"$SCRIPT_DIR/../install.sh"

echo "Verifying backup was created:"
if ls ~/.zshrc.backup >/dev/null 2>&1; then
    echo "✅ Backup created"
else
    echo "❌ Backup failed"
fi

echo "Verifying symlink was created:"
if ls -la ~/.zshrc | grep -q "$(cd "$SCRIPT_DIR/.." && pwd)/home"; then
    echo "✅ Symlink created"
else
    echo "❌ Symlink failed"
fi

# Cleanup
rm -f ~/.zshrc.backup ~/.zshrc.test-backup

echo "✅ Test completed" 
