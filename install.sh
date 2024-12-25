#!/bin/bash

config_file="$HOME/.bashrc"

# Create the function definition to be added to bashrc
function_def='
function add-alias() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: add-alias <alias_name> <command>"
        echo "Example: add-alias gc '\''git commit'\''"
        return 1
    fi

    local alias_name="$1"
    local command="$2"

    # Check if alias already exists
    if grep -q "alias $alias_name=" "$HOME/.bashrc"; then
        echo "Alias '\''$alias_name'\'' already exists"
        return 1
    fi

    # Add the alias
    echo "alias $alias_name='\''$command'\''" >> "$HOME/.bashrc"
    echo "Added alias: $alias_name='\''$command'\''"
    
    # Reload bashrc
    source "$HOME/.bashrc"
    echo "Bashrc reloaded! New alias is ready to use."
}
'

# Add the function to bashrc if it doesn't exist
if ! grep -q "function add-alias()" "$config_file"; then
    source "$HOME/.bashrc"
    echo "$function_def" >> "$config_file"
    echo "Added add-alias function to .bashrc"
else
    echo "add-alias function already exists in .bashrc"
fi
