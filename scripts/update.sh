#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"
BACKUP="$DOT/backups/update_$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"

echo "====================================="
echo "   Dot Files Update Script"
echo "====================================="
echo ""
echo "Backup location: $BACKUP"
echo ""

# Verify dot_files directory exists
if [ ! -d "$DOT" ]; then
  echo "✗ Error: $DOT directory not found!"
  exit 1
fi

###############################################
# 1. Sync ~/.config/*
###############################################
echo "[1/4] Syncing ~/.config directories..."
for d in "$DOT/config/"*; do
  [ -e "$d" ] || continue  # Skip if no files match
  name=$(basename "$d")
  src="$HOME/.config/$name"
  
  if [ -d "$src" ] && [ ! -L "$src" ]; then
    # Only sync if source is a real directory (not a symlink)
    echo "    Backing up $d..."
    cp -a "$d" "$BACKUP"/ 2>/dev/null || true
    echo "    Syncing $src → $d"
    rsync -av --delete "$src"/ "$d"/
    echo "    ✓ Updated $d"
  elif [ -L "$src" ]; then
    echo "    ⊙ Skipping $name (already a symlink)"
  else
    echo "    ⚠ Warning: $src not found, skipping"
  fi
done
echo ""

###############################################
# 2. Sync ~/ dotfiles
###############################################
echo "[2/4] Syncing home dotfiles..."
if [ -d "$DOT/home" ]; then
  for f in "$DOT/home/".[!.]*; do
    [ -e "$f" ] || continue  # Skip if no files match
    name=$(basename "$f")
    src="$HOME/$name"
    
    if [ -e "$src" ] && [ ! -L "$src" ]; then
      # Only sync if source exists and is not a symlink
      echo "    Backing up $name..."
      cp -a "$src" "$BACKUP"/ 2>/dev/null || true
      echo "    Syncing $src → $f"
      cp -f "$src" "$f"
      echo "    ✓ Updated $f"
    elif [ -L "$src" ]; then
      echo "    ⊙ Skipping $name (already a symlink)"
    else
      echo "    ⚠ Warning: $src not found, skipping"
    fi
  done
else
  echo "    ⚠ Warning: $DOT/home directory not found, skipping"
fi
echo ""

###############################################
# 3. Sync Oh My Zsh custom plugins
###############################################
echo "[3/4] Syncing Oh My Zsh custom plugins..."
OHZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_SRC="$OHZSH_CUSTOM/plugins"
PLUGINS_DST="$DOT/config/oh-my-zsh/custom/plugins"

if [ -d "$PLUGINS_SRC" ]; then
  mkdir -p "$PLUGINS_DST"
  
  for plugin in "$PLUGINS_SRC"/*; do
    [ -e "$plugin" ] || continue  # Skip if no plugins found
    [ -d "$plugin" ] || continue  # Skip if not a directory
    
    name=$(basename "$plugin")
    
    # Backup existing plugin in repo
    if [ -d "$PLUGINS_DST/$name" ]; then
      echo "    Backing up plugin: $name"
      cp -a "$PLUGINS_DST/$name" "$BACKUP"/ 2>/dev/null || true
    fi
    
    # Sync plugin
    echo "    Syncing $name..."
    rsync -av --delete "$plugin"/ "$PLUGINS_DST/$name"/
    echo "    ✓ Updated plugin: $name"
  done
else
  echo "    ⚠ Warning: Oh My Zsh custom plugins directory not found, skipping"
fi
echo ""

###############################################
# 4. Sync aliases
###############################################
echo "[4/4] Syncing aliases file..."
ALIASES_SRC="$HOME/.aliases"
ALIASES_DST="$DOT/shell/linux_aliases.sh"

if [ -f "$ALIASES_SRC" ] && [ ! -L "$ALIASES_SRC" ]; then
  # Only sync if source exists and is not a symlink
  echo "    Backing up aliases..."
  cp -a "$ALIASES_DST" "$BACKUP"/ 2>/dev/null || true
  echo "    Syncing $ALIASES_SRC → $ALIASES_DST"
  cp -f "$ALIASES_SRC" "$ALIASES_DST"
  echo "    ✓ Updated aliases"
elif [ -L "$ALIASES_SRC" ]; then
  echo "    ⊙ Aliases already symlinked (no sync needed)"
else
  echo "    ⚠ Warning: ~/.aliases not found, skipping"
fi
echo ""

# Note: Scripts in ~/scripts are already symlinked to ~/dot_files/scripts
# Any changes to scripts are automatically reflected in the repo
# No need to sync them back

echo "====================================="
echo "✓ Update Complete!"
echo "====================================="
echo ""
echo "Backup saved to:"
echo "  $BACKUP"
echo ""
echo "Changes synced from system to repository."
echo "Don't forget to commit and push your changes!"
echo ""
