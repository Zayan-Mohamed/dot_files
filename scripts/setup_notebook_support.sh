#!/usr/bin/env bash

# Setup script for Jupyter Notebook support in Neovim
# This script helps you set up Python dependencies for molten-nvim

set -e

VENV_DIR="$HOME/.virtualenvs/neovim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================="
echo "Neovim Jupyter Notebook Setup"
echo "=========================================="
echo

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is not installed"
    echo "Please install Python 3.10 or higher"
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✓ Found Python $PYTHON_VERSION"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo
    echo "Creating virtual environment at $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
    echo "✓ Virtual environment created"
else
    echo "✓ Virtual environment already exists"
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate"

echo
echo "Installing required Python packages..."
echo "---------------------------------------"

# Required packages
echo "Installing required packages..."
pip install --upgrade pip
pip install pynvim jupyter_client

echo
echo "Installing optional packages for enhanced features..."

# Optional packages with descriptions
declare -A OPTIONAL_PACKAGES=(
    ["cairosvg"]="SVG rendering with transparency"
    ["pnglatex"]="LaTeX formula rendering"
    ["plotly"]="Plotly figure support"
    ["kaleido"]="Plotly rendering engine"
    ["pyperclip"]="Clipboard operations"
    ["nbformat"]="Jupyter notebook format support"
    ["pillow"]="Image operations"
    ["ipykernel"]="Jupyter kernel for Python"
)

for package in "${!OPTIONAL_PACKAGES[@]}"; do
    echo "  - Installing $package (${OPTIONAL_PACKAGES[$package]})..."
    pip install "$package" 2>/dev/null || echo "    ⚠ Failed to install $package (optional)"
done

echo
echo "✓ Python packages installed"

# Install Python kernel
echo
echo "Installing Python kernel for Jupyter..."
python -m ipykernel install --user --name=neovim-python3 --display-name "Python 3 (Neovim)"
echo "✓ Kernel installed"

# Create or update Neovim config to use this venv
NVIM_CONFIG="$HOME/.config/nvim/lua/globals.lua"
PYTHON_HOST_LINE="vim.g.python3_host_prog = vim.fn.expand('$VENV_DIR/bin/python3')"

echo
echo "Configuring Neovim to use this virtual environment..."

if [ -f "$NVIM_CONFIG" ]; then
    # Check if line already exists
    if grep -q "vim.g.python3_host_prog" "$NVIM_CONFIG"; then
        echo "  Python host already configured in $NVIM_CONFIG"
    else
        echo "  Adding Python host configuration to $NVIM_CONFIG"
        echo "" >> "$NVIM_CONFIG"
        echo "-- Python host program for remote plugins (molten-nvim)" >> "$NVIM_CONFIG"
        echo "$PYTHON_HOST_LINE" >> "$NVIM_CONFIG"
    fi
else
    echo "  Creating $NVIM_CONFIG"
    mkdir -p "$(dirname "$NVIM_CONFIG")"
    cat > "$NVIM_CONFIG" << EOF
-- Neovim global configurations

-- Python host program for remote plugins (molten-nvim)
$PYTHON_HOST_LINE
EOF
fi

echo "✓ Configuration updated"

# Instructions
echo
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo
echo "Next steps:"
echo "1. Restart Neovim"
echo "2. Run: :UpdateRemotePlugins"
echo "3. Restart Neovim again"
echo "4. Run: :checkhealth molten"
echo
echo "To start using notebooks:"
echo "  nvim notebook.md"
echo "  <localleader>mi  (Initialize kernel)"
echo
echo "Available kernels:"
jupyter kernelspec list

echo
echo "For more information, see:"
echo "  $SCRIPT_DIR/NOTEBOOK_SETUP.md"
echo
