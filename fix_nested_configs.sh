#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files/config"
BACKUP="$HOME/dot_files_fix_all_backup_$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"
shopt -s dotglob

for d in "$DOT"/*; do
  [ -d "$d" ] || continue
  name=$(basename "$d")
  if [ -d "$d/$name" ]; then
    echo "Fixing nested for: $name"
    cp -a "$d" "$BACKUP"/ || true
    mv -v "$d/$name/"* "$d/" || true
    rmdir "$d/$name" || true
    # recreate symlink in ~/.config if present
    if [ -L "$HOME/.config/$name" ] || [ -d "$HOME/.config/$name" ]; then
      rm -rf "$HOME/.config/$name"
    fi
    ln -sfn "$d" "$HOME/.config/$name"
  fi
done

echo "Done. Backups are in: $BACKUP"
