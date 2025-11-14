#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"

echo "[*] Linking configs..."

# 1. Link ~/.config/*
for d in "$DOT/config/"*; do
  name=$(basename "$d")
  target="$HOME/.config/$name"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$d" "$target"
  echo "    Linked $target → $d"
done

# 2. Link ~/.* dotfiles
for f in "$DOT/home/"*; do
  name=$(basename "$f")
  target="$HOME/$name"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$f" "$target"
  echo "    Linked $target → $f"
done

# 3. Link aliases file as ~/.aliases
if [ -f "$DOT/shell/linux_aliases.sh" ]; then
  target="$HOME/.aliases"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$DOT/shell/linux_aliases.sh" "$target"
  echo "    Linked $target → $DOT/shell/linux_aliases.sh"
fi

# 4. Ensure Oh My Zsh custom plugins are installed
PLUGIN_INSTALLER="$DOT/scripts/install_zsh_plugins.sh"
if [ -x "$PLUGIN_INSTALLER" ]; then
  echo "[*] Ensuring Zsh plugins are installed..."
  "$PLUGIN_INSTALLER"
fi

# 5. Link scripts folder (optional, for convenience)
SCRIPTS_SRC="$DOT/scripts"
SCRIPTS_TARGET="$HOME/scripts"
if [ -d "$SCRIPTS_SRC" ]; then
  if [ -e "$SCRIPTS_TARGET" ] || [ -L "$SCRIPTS_TARGET" ]; then
    echo "    Removing existing $SCRIPTS_TARGET"
    rm -rf "$SCRIPTS_TARGET"
  fi
  ln -sfn "$SCRIPTS_SRC" "$SCRIPTS_TARGET"
  echo "    Linked $SCRIPTS_TARGET → $SCRIPTS_SRC"
fi

echo "[✓] All configs linked."
