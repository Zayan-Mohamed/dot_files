#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"
BACKUP="$DOT/backups/update_$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"

echo "[*] Syncing configs back into repo (backups in $BACKUP)"

# Copy ~/.config/* back
for d in "$DOT/config/"*; do
  name=$(basename "$d")
  src="$HOME/.config/$name"
  if [ -d "$src" ]; then
    cp -a "$src" "$BACKUP"/ || true
    rsync -av --delete "$src"/ "$d"/
    echo "    Updated $d from $src"
  fi
done

# Copy ~/.* back
for f in "$DOT/home/"*; do
  name=$(basename "$f")
  src="$HOME/$name"
  if [ -f "$src" ]; then
    cp -a "$src" "$BACKUP"/ || true
    cp -f "$src" "$f"
    echo "    Updated $f from $src"
  fi
done

echo "[✓] Sync complete."
