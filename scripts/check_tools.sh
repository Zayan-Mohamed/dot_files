#!/usr/bin/env bash
# Check for recommended CLI tools and provide installation instructions

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   Recommended Tools Check${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Define tools with installation methods
declare -A tools=(
    # Format: "command:name:description:install_method"
    ["nvim"]="nvim:Neovim:Modern extensible text editor:snap install nvim --classic"
    ["eza"]="eza:Eza:Modern ls replacement with icons:cargo install eza"
    ["batcat"]="batcat:Bat:Cat with syntax highlighting:apt install bat"
    ["fd"]="fd:Fd:Fast alternative to find:cargo install fd-find"
    ["rg"]="rg:Ripgrep:Fast grep alternative:cargo install ripgrep"
    ["fzf"]="fzf:FZF:Fuzzy finder for CLI:apt install fzf"
    ["htop"]="htop:Htop:Interactive process viewer:apt install htop"
    ["btop"]="btop:Btop:Modern resource monitor:snap install btop"
    ["zoxide"]="zoxide:Zoxide:Smarter cd command:cargo install zoxide"
    ["delta"]="delta:Delta:Better git diff:cargo install git-delta"
    ["procs"]="procs:Procs:Modern ps replacement:cargo install procs"
    ["dust"]="dust:Dust:Modern du replacement:cargo install du-dust"
    ["duf"]="duf:Duf:Modern df replacement:apt install duf"
    ["tldr"]="tldr:TLDR:Simplified man pages:npm install -g tldr"
    ["jq"]="jq:jq:JSON processor:apt install jq"
    ["lazygit"]="lazygit:LazyGit:Terminal UI for git:apt install lazygit"
)

installed=0
missing=0

echo -e "${BLUE}Checking installed tools...${NC}"
echo ""

for cmd in "${!tools[@]}"; do
    IFS=: read -r command name desc install <<< "${tools[$cmd]}"
    
    if command -v "$command" >/dev/null 2>&1; then
        version=$(eval "$command --version 2>&1 | head -1" 2>/dev/null || echo "")
        echo -e "${GREEN}✓${NC} $name - $desc"
        [ -n "$version" ] && echo -e "  ${YELLOW}$version${NC}"
        ((installed++))
    else
        echo -e "${RED}✗${NC} $name - $desc"
        echo -e "  ${BLUE}Install:${NC} $install"
        ((missing++))
    fi
    echo ""
done

# Check for Rust/Cargo (needed for many tools)
echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   Build Tools${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

if command -v cargo >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Rust/Cargo installed"
    cargo --version
else
    echo -e "${RED}✗${NC} Rust/Cargo not installed"
    echo -e "  ${BLUE}Install:${NC} curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    echo -e "  ${YELLOW}Note: Many modern tools are built with Rust${NC}"
fi
echo ""

if command -v npm >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Node.js/npm installed"
    npm --version
else
    echo -e "${RED}✗${NC} Node.js/npm not installed"
    echo -e "  ${BLUE}Install:${NC} apt install nodejs npm"
fi
echo ""

# Summary
echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   Summary${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""
echo -e "Installed: ${GREEN}$installed${NC}"
echo -e "Missing:   ${RED}$missing${NC}"
echo ""

if [ $missing -eq 0 ]; then
    echo -e "${GREEN}✓ All recommended tools are installed!${NC}"
else
    echo -e "${YELLOW}Install missing tools to enhance your workflow.${NC}"
    echo ""
    echo "Quick installation (requires Rust):"
    echo "  cargo install eza bat fd-find ripgrep git-delta procs du-dust zoxide"
    echo ""
    echo "Quick installation (apt):"
    echo "  sudo apt install fzf htop duf jq lazygit"
fi

exit 0
