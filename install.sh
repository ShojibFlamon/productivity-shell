#!/usr/bin/env bash
# Dotfiles installer

# 1. Create aliases directory
mkdir -p ~/.aliases

# 2. Copy all alias files
cp -r ./aliases/* ~/.aliases/

# 3. Add loader to shell config
for shellrc in ~/.bashrc ~/.zshrc; do
  if ! grep -q "Load all custom aliases" "$shellrc"; then
    echo -e "\n# Load all custom aliases and functions" >> "$shellrc"
    echo 'for file in "$HOME/.aliases"/*.sh; do [ -r "$file" ] && source "$file"; done' >> "$shellrc"
    echo "Loader added to $shellrc"
  fi
done

echo "✅ Dotfiles installed! Reload your shell or run: source ~/.bashrc or source ~/.zshrc"
