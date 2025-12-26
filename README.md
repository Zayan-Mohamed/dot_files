# dot_files

![OS](https://img.shields.io/badge/os-linux-blue)
![Shell](https://img.shields.io/badge/shell-zsh-green)
![Editor](https://img.shields.io/badge/editor-neovim-57A143)
![License](https://img.shields.io/badge/license-MIT-black)


A fully reproducible Linux development environment built around symlinks.

This repository manages everything in `~/.config` and essential dotfiles in `~`, all tracked in one place and safely symlinked back to the system.  
The goal is simple: clone the repo, run one script, and get *your exact setup* every time.

No manual copying. No drift. No mystery state.

---

### What this repo gives you

- A clean, versioned `~/.config`
- Predictable dotfiles in `~`
- Idempotent install and update scripts
- Health checks to catch broken symlinks
- A heavily tuned Neovim setup with documentation
- A Zsh environment that feels fast, safe, and modern


## Structure

```
dot_files/
│
├── config/                 # mirrors ~/.config
│   ├── alacritty/
│   ├── kitty/
│   ├── wezterm/
│   ├── ghostty/
│   ├── nvim/
│   └── ...                     # other app configs
│
├── home/                       # dotfiles in ~ (not ~/.config)
│   ├── .bashrc
│   ├── .zshrc
│   ├── .p10k.zsh
│   ├── .gitconfig
│   ├── .aliases
│   └── ...
│
├── scripts/                    # helper scripts
│   ├── install.sh              # links all configs, dotfiles, and scripts; ensures Zsh plugins installed
│   ├── update.sh               # syncs system configs and plugins back into the repo with backups
│   ├── install_zsh_plugins.sh  # installs missing Zsh plugins (syntax highlighting, history search)
│   ├── health_check.sh         # verifies symlinks and checks dependencies
│   ├── check_tools.sh          # checks for recommended CLI tools
│   └── fix_nested.sh           # flattens accidental nested directories
│
├── shell/                      # shell configuration
│   └── linux_aliases.sh        # custom aliases (linked to ~/.aliases)
│
├── QUICKSTART.md               # 5-minute setup guide
├── DEPENDENCIES.md             # required and optional dependencies
├── NVIM_STUDY_GUIDE.md         # comprehensive Neovim usage guide
└── README.md
```

---

## Setup

Clone into your home directory:

```bash
git clone git@github.com:Zayan-Mohamed/dot_files.git ~/dot_files
cd ~/dot_files
```

---

> **Warning**
> This repo is designed for **your personal setup**.
> Always review scripts before running them on a new machine.

### 1. Link configs

Run the main install script:

```bash
~/dot_files/scripts/install.sh
```

This will:

- Symlink all `~/.config/*` directories
- Symlink home dotfiles in `~/dot_files/home/`
- Symlink your scripts folder to `~/scripts`
- Ensure required Oh My Zsh plugins (`zsh-syntax-highlighting` and `zsh-history-substring-search`) are installed
- Safely remove any existing conflicting files or symlinks

---

### 2. Update repo from system

Whenever you make changes to your configs on the system, run:

```bash
~/dot_files/scripts/update.sh
```

This will:

- Backup your current repo files to a timestamped folder in `dot_files/backups/`
- Sync `~/.config/*` and tracked dotfiles back into the repo
- Sync Oh My Zsh custom plugins
- Keep scripts and `.p10k.zsh` up-to-date

---

---

## � Quick Commands

### Check System Health

```bash
~/scripts/health_check.sh    # Verify symlinks and essential tools
~/scripts/check_tools.sh     # Check for recommended modern CLI tools
```

### Common Tasks

```bash
~/scripts/install.sh         # Initial setup or re-link configs
~/scripts/update.sh          # Sync changes back to repo
source ~/.zshrc              # Reload shell configuration
```

---

## �📚 Documentation

### 📖 Guides

- **[QUICKSTART.md](./QUICKSTART.md)** - Get started in 5 minutes
- **[DEPENDENCIES.md](./DEPENDENCIES.md)** - All required and optional dependencies
- **[KEYBINDINGS](./NVIM_KEYBINDINGS.md)** - Reference for all keybindings in your Neovim configuration

### Neovim Study Guide

A comprehensive guide to using the Neovim configuration efficiently is available at:

**[NVIM_STUDY_GUIDE.md](./NVIM_STUDY_GUIDE.md)**

This guide includes:

- **Core Keybindings** - Essential shortcuts and leader key mappings
- **File Navigation & Search** - FZF-Lua fuzzy finding and nvim-tree usage
- **Text Editing Superpowers** - vim-sandwich, commentary, yanky, and advanced motions
- **LSP & Code Intelligence** - Code navigation, refactoring, and autocompletion
- **Git Integration** - Gitsigns, Fugitive, and visual diff tools
- **Buffer & Window Management** - Efficient multi-file workflows
- **Advanced Navigation** - Hop.nvim, folding, and custom text objects
- **Productivity Plugins** - Complete overview of all 80+ plugins
- **6-Week Learning Path** - Structured approach to mastery
- **Practice Exercises** - Hands-on scenarios to build muscle memory

Perfect for both beginners learning Neovim and experienced users wanting to leverage the full power of this configuration.

---

## ✨ What's New (Recent Enhancements)

### Scripts

- ✅ **health_check.sh** - Verify all symlinks and dependencies
- ✅ **check_tools.sh** - Check for modern CLI tools with installation instructions
- ✅ Fixed bug in `update.sh` that was copying scripts to themselves

### Configuration

- ✅ **Global .gitignore** - Comprehensive gitignore for all projects
- ✅ **Enhanced Git aliases** - Better git log, undo, cleanup, and more
- ✅ **Modern CLI tool aliases** - Conditional aliases for bat, fd, rg, dust, etc.
- ✅ **Safety aliases** - Interactive cp, mv, ln to prevent accidents
- ✅ **Improved history** - Shared history across sessions, better deduplication
- ✅ **Development shortcuts** - Quick navigation, editing, and workflow aliases

### Documentation

- ✅ **QUICKSTART.md** - Fast onboarding for new users
- ✅ **DEPENDENCIES.md** - Complete dependency documentation
- ✅ **NVIM_STUDY_GUIDE.md** - Comprehensive Neovim learning guide
- ✅ **ENHANCEMENT_PLAN.md** - Future improvements roadmap

### Structure

- ✅ Moved shell configs (.zshrc, .bashrc, .gitconfig) to proper `home/` location
- ✅ Better organization and consistency

---

## 🎯 Features

### Terminals

- **Alacritty** - GPU-accelerated, highly configurable
- **Kitty** - Advanced features with ligatures
- **Ghostty** - Modern, native terminal

### Shell (Zsh)

- **Powerlevel10k** theme with beautiful prompts
- **Syntax highlighting** as you type
- **Autosuggestions** from command history
- **Smart history** shared across all sessions
- **Modern aliases** for common tasks

### Editor (Neovim)

- 80+ plugins pre-configured
- LSP support for Python, Lua, Bash, YAML, Vim
- Fuzzy finding with FZF-lua
- Git integration with Fugitive, Gitsigns
- Treesitter syntax highlighting
- See full guide in [NVIM_STUDY_GUIDE.md](./NVIM_STUDY_GUIDE.md)

---

### Notes

- The install script is **idempotent** — you can run it multiple times safely.
- Plugin installer (`install_zsh_plugins.sh`) runs automatically during linking but only installs missing plugins.
- Designed for fully reproducible setups on fresh machines.
