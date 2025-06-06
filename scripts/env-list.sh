#!/bin/bash

ENV_FILE="$HOME/.env"

echo "Environment variables in ~/.env:"
echo

if [[ ! -f "$ENV_FILE" ]]; then
    echo "No ~/.env file found"
    echo "Use 'config env set' to create one"
    exit 0
fi

# Show the contents with some formatting
while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Pretty print the variable
    if [[ "$line" =~ ^export[[:space:]]+ ]]; then
        echo "  ${line#export }"
    else
        echo "  $line"
    fi
done < "$ENV_FILE"

echo
echo "Use 'config env set' to edit these variables" 
