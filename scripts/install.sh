#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"

echo "[*] Linking configs..."

# Link ~/.config/*
for d in "$DOT/config/"*; do
  name=$(basename "$d")
  target="$HOME/.config/$name"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$d" "$target"
  echo "    Linked $target → $d"
done

# Link ~/dotfiles (home)
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

# Link aliases file as ~/.aliases
if [ -f "$DOT/shell/linux_aliases.sh" ]; then
  target="$HOME/.aliases"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$DOT/shell/linux_aliases.sh" "$target"
  echo "    Linked $target → $DOT/shell/linux_aliases.sh"
fi

if [ -x "$DOT/scripts/install_zsh_plugins.sh" ]; then
  echo "[*] Ensuring Zsh plugins are installed..."
  "$DOT/scripts/install_zsh_plugins.sh"
fi

echo "[✓] All configs linked."

