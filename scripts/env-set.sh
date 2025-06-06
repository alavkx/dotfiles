#!/bin/bash

ENV_FILE="$HOME/.env"

# Create ~/.env if it doesn't exist with some examples
if [[ ! -f "$ENV_FILE" ]]; then
    echo "Creating ~/.env with examples..."
    cat > "$ENV_FILE" << 'EOF'
# Global environment variables
# Add your environment variables here using export syntax

# Examples:
# export EDITOR="code"
# export BROWSER="chrome"
# export API_KEY="your-api-key"

EXAMPLE_VAR="example_value"
EOF
fi

# Get modification time before editing
BEFORE_TIME=$(stat -f %m "$ENV_FILE" 2>/dev/null || echo 0)

echo "Opening ~/.env in Cursor..."
echo "Save and close the editor to reload environment variables"

# Open in Cursor and wait for it to close (like git commit message flow)
if command -v cursor >/dev/null 2>&1; then
    cursor --wait "$ENV_FILE"
elif command -v code >/dev/null 2>&1; then
    code --wait "$ENV_FILE"
else
    echo "Neither 'cursor' nor 'code' command found"
    echo "Please install Cursor or VSCode CLI"
    exit 1
fi

# Check if file was modified
AFTER_TIME=$(stat -f %m "$ENV_FILE" 2>/dev/null || echo 0)

if [[ "$AFTER_TIME" -gt "$BEFORE_TIME" ]]; then
    echo "Environment file updated. Reloading..."
    
    # Source the file to load variables into current shell
    source "$ENV_FILE"
    
    echo "✅ Environment variables loaded into current session"
    echo "Restart your shell or run 'source ~/.env' in other terminals"
else
    echo "No changes made to ~/.env"
fi 
