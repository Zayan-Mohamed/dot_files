#!/usr/bin/env bash
# Health Check Script for dot_files
# Verifies symlinks, checks dependencies, and reports issues

set -euo pipefail

DOT="$HOME/dot_files"
ERRORS=0
WARNINGS=0

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   Dot Files Health Check${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Function to print status
print_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    WARNINGS=$((WARNINGS + 1))
}

print_error() {
    echo -e "${RED}✗${NC} $1"
    ERRORS=$((ERRORS + 1))
}

# Check if dot_files directory exists
echo -e "${BLUE}[1/6] Checking dot_files structure...${NC}"
if [ ! -d "$DOT" ]; then
    print_error "dot_files directory not found at $DOT"
    exit 1
fi

for dir in config home scripts shell; do
    if [ -d "$DOT/$dir" ]; then
        print_ok "$dir/ directory exists"
    else
        print_warning "$dir/ directory missing"
    fi
done
echo ""

# Check symlinks for config files
echo -e "${BLUE}[2/6] Checking ~/.config symlinks...${NC}"
for d in "$DOT/config/"*; do
    name=$(basename "$d")
    
    # Skip documentation files
    if [[ "$name" == *.md ]] || [[ "$name" == *.txt ]]; then
        continue
    fi
    
    target="$HOME/.config/$name"
    
    if [ -L "$target" ]; then
        if [ -e "$target" ]; then
            print_ok "$name: symlink valid"
        else
            print_error "$name: broken symlink"
        fi
    elif [ -e "$target" ]; then
        print_warning "$name: exists but is not a symlink"
    else
        print_warning "$name: not linked"
    fi
done
echo ""

# Check home dotfiles
echo -e "${BLUE}[3/6] Checking ~/ dotfile symlinks...${NC}"
# Use find to get both files and directories, avoiding glob expansion issues
while IFS= read -r -d '' f; do
    name=$(basename "$f")
    target="$HOME/$name"
    
    if [ -L "$target" ]; then
        if [ -e "$target" ]; then
            print_ok "$name: symlink valid"
        else
            print_error "$name: broken symlink"
        fi
    elif [ -e "$target" ]; then
        print_warning "$name: exists but is not a symlink"
    else
        print_warning "$name: not linked"
    fi
done < <(find "$DOT/home" -maxdepth 1 \( -type f -o -type d \) -name '.*' -print0)
echo ""

# Check aliases file
echo -e "${BLUE}[4/6] Checking aliases...${NC}"
if [ -L "$HOME/.aliases" ]; then
    if [ -e "$HOME/.aliases" ]; then
        print_ok "~/.aliases symlink valid"
    else
        print_error "~/.aliases broken symlink"
    fi
else
    print_warning "~/.aliases not linked"
fi
echo ""

# Check essential tools
echo -e "${BLUE}[5/6] Checking essential tools...${NC}"
essential_tools=(
    "zsh:Zsh shell"
    "git:Git version control"
    "nvim:Neovim editor"
)

for tool in "${essential_tools[@]}"; do
    cmd="${tool%%:*}"
    desc="${tool#*:}"
    if command -v "$cmd" >/dev/null 2>&1; then
        version=$(eval "$cmd --version 2>&1 | head -1" || echo "unknown")
        print_ok "$desc installed: $version"
    else
        print_error "$desc not found"
    fi
done
echo ""

# Check recommended tools
echo -e "${BLUE}[6/6] Checking recommended tools...${NC}"
recommended_tools=(
    "eza:Modern ls replacement"
    "bat|batcat:Better cat with syntax highlighting"
    "fd|fdfind:Better find"
    "rg:Ripgrep (better grep)"
    "fzf:Fuzzy finder"
    "htop:System monitor"
)

for tool in "${recommended_tools[@]}"; do
    cmd="${tool%%:*}"
    desc="${tool#*:}"
    
    # Check if cmd contains alternatives (e.g., "bat|batcat")
    if [[ "$cmd" == *"|"* ]]; then
        IFS='|' read -ra alternatives <<< "$cmd"
        found=false
        for alt in "${alternatives[@]}"; do
            if command -v "$alt" >/dev/null 2>&1; then
                found=true
                break
            fi
        done
        if $found; then
            print_ok "$desc installed"
        else
            print_warning "$desc not installed (optional)"
        fi
    else
        if command -v "$cmd" >/dev/null 2>&1; then
            print_ok "$desc installed"
        else
            print_warning "$desc not installed (optional)"
        fi
    fi
done
echo ""

# Summary
echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   Summary${NC}"
echo -e "${BLUE}=====================================${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ Everything looks great!${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${NC}"
    echo ""
    echo "To fix warnings:"
    echo "  1. Run: ~/dot_files/scripts/install.sh"
    echo "  2. Install recommended tools: ~/dot_files/scripts/check_tools.sh"
    exit 0
else
    echo -e "${RED}✗ $ERRORS error(s) and $WARNINGS warning(s) found${NC}"
    echo ""
    echo "To fix errors:"
    echo "  1. Run: ~/dot_files/scripts/install.sh"
    echo "  2. Check for broken symlinks"
    exit 1
fi
