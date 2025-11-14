#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$PLUGIN_DIR"

plugins_to_install=(
  zsh-syntax-highlighting
  zsh-history-substring-search
)

for plugin in "${plugins_to_install[@]}"; do
  if [ ! -d "$PLUGIN_DIR/$plugin" ]; then
    echo "[*] Installing missing Zsh plugin: $plugin"
    git clone "https://github.com/zsh-users/$plugin.git" \
      "$PLUGIN_DIR/$plugin"
  else
    echo "[✓] Plugin already installed: $plugin"
  fi
done

echo "[✓] Done."
