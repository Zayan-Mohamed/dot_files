#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"
BACKUP="$DOT/backups/update_$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"

echo "[*] Syncing configs back into repo (backups in $BACKUP)"

# 1. Sync ~/.config/*
for d in "$DOT/config/"*; do
  name=$(basename "$d")
  src="$HOME/.config/$name"
  if [ -d "$src" ]; then
    cp -a "$d" "$BACKUP"/ || true
    rsync -av --delete "$src"/ "$d"/
    echo "    Updated $d from $src"
  fi
done

# 2. Sync ~/.* dotfiles
for f in "$DOT/home/"*; do
  name=$(basename "$f")
  src="$HOME/$name"
  if [ -f "$src" ]; then
    cp -a "$f" "$BACKUP"/ || true
    cp -f "$src" "$f"
    echo "    Updated $f from $src"
  fi
done

# 3. Sync Oh My Zsh custom plugins
OHZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_SRC="$OHZSH_CUSTOM/plugins"
PLUGINS_DST="$DOT/config/oh-my-zsh/custom/plugins"
mkdir -p "$PLUGINS_DST"

for plugin in "$PLUGINS_SRC"/*; do
  name=$(basename "$plugin")
  cp -a "$PLUGINS_DST/$name" "$BACKUP"/ || true
  rsync -av --delete "$plugin"/ "$PLUGINS_DST/$name"/
  echo "    Updated plugin $name"
done

# 4. Sync scripts folder
SCRIPTS_SRC="$DOT/scripts"
if [ -d "$SCRIPTS_SRC" ]; then
  cp -a "$SCRIPTS_SRC" "$BACKUP"/ || true
  rsync -av --delete "$SCRIPTS_SRC"/ "$SCRIPTS_SRC"/
  echo "    Updated scripts"
fi

# 5. Sync .p10k.zsh if exists
if [ -f "$HOME/.p10k.zsh" ]; then
  cp -a "$DOT/home/.p10k.zsh" "$BACKUP"/ || true
  cp -f "$HOME/.p10k.zsh" "$DOT/home/.p10k.zsh"
  echo "    Updated .p10k.zsh"
fi

echo "[✓] Sync complete."

