#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$PLUGIN_DIR"

plugins_to_install=(
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-autopair
)

declare -A plugin_repos=(
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  [zsh-history-substring-search]="https://github.com/zsh-users/zsh-history-substring-search.git"
  [zsh-autopair]="https://github.com/hlissner/zsh-autopair.git"
)

for plugin in "${plugins_to_install[@]}"; do
  if [ ! -d "$PLUGIN_DIR/$plugin" ]; then
    echo "[*] Installing missing Zsh plugin: $plugin"
    git clone "${plugin_repos[$plugin]}" "$PLUGIN_DIR/$plugin"
  else
    echo "[✓] Plugin already installed: $plugin"
  fi
done

echo "[✓] All plugins installed."
