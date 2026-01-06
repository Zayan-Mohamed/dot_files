#!/usr/bin/env bash
set -euo pipefail

DOT="$HOME/dot_files"

echo "====================================="
echo "   Dot Files Installation Script"
echo "====================================="
echo ""

# Verify dot_files directory exists
if [ ! -d "$DOT" ]; then
  echo "✗ Error: $DOT directory not found!"
  echo "  Please clone the repository to $DOT first."
  exit 1
fi

echo "[*] Linking configs..."
echo ""

# 1. Link ~/.config/*
echo "[1/5] Linking ~/.config directories..."
for d in "$DOT/config/"*; do
  [ -e "$d" ] || continue  # Skip if no files match
  name=$(basename "$d")
  
  # Skip documentation files
  if [[ "$name" == *.md ]] || [[ "$name" == *.txt ]]; then
    echo "    ⊘ Skipping documentation file: $name"
    continue
  fi
  
  target="$HOME/.config/$name"
  mkdir -p "$(dirname "$target")"
  
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  
  ln -sfn "$d" "$target"
  echo "    ✓ Linked $target → $d"
done
echo ""

# 2. Link ~/.* dotfiles from home/
echo "[2/5] Linking home dotfiles..."
if [ -d "$DOT/home" ]; then
  for f in "$DOT/home/".[!.]*; do
    [ -e "$f" ] || continue  # Skip if no files match
    name=$(basename "$f")
    target="$HOME/$name"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
      echo "    Removing existing $target"
      rm -rf "$target"
    fi
    
    ln -sfn "$f" "$target"
    echo "    ✓ Linked $target → $f"
  done
else
  echo "    ⚠ Warning: $DOT/home directory not found, skipping"
fi
echo ""

# 3. Link aliases file as ~/.aliases
echo "[3/5] Linking aliases file..."
if [ -f "$DOT/shell/linux_aliases.sh" ]; then
  target="$HOME/.aliases"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "    Removing existing $target"
    rm -rf "$target"
  fi
  ln -sfn "$DOT/shell/linux_aliases.sh" "$target"
  echo "    ✓ Linked $target → $DOT/shell/linux_aliases.sh"
else
  echo "    ⚠ Warning: $DOT/shell/linux_aliases.sh not found, skipping"
fi
echo ""

# 4. Ensure Oh My Zsh custom plugins are installed
echo "[4/5] Installing Zsh plugins..."
PLUGIN_INSTALLER="$DOT/scripts/install_zsh_plugins.sh"
if [ -x "$PLUGIN_INSTALLER" ]; then
  "$PLUGIN_INSTALLER"
else
  echo "    ⚠ Warning: Plugin installer not found or not executable, skipping"
fi
echo ""

# 5. Link scripts folder (optional, for convenience)
echo "[5/5] Linking scripts directory..."
SCRIPTS_SRC="$DOT/scripts"
SCRIPTS_TARGET="$HOME/scripts"
if [ -d "$SCRIPTS_SRC" ]; then
  if [ -e "$SCRIPTS_TARGET" ] || [ -L "$SCRIPTS_TARGET" ]; then
    echo "    Removing existing $SCRIPTS_TARGET"
    rm -rf "$SCRIPTS_TARGET"
  fi
  ln -sfn "$SCRIPTS_SRC" "$SCRIPTS_TARGET"
  echo "    ✓ Linked $SCRIPTS_TARGET → $SCRIPTS_SRC"
else
  echo "    ⚠ Warning: $SCRIPTS_SRC not found, skipping"
fi
echo ""

echo "====================================="
echo "✓ Installation Complete!"
echo "====================================="
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. Run health check: ~/scripts/health_check.sh"
echo ""
