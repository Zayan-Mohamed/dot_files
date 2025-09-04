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

echo "[✓] All configs linked."
