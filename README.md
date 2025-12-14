# dot_files

My personal Linux configuration files (terminals, editors, and tools).

This repo manages everything in `~/.config` and my dotfiles in `~`.
Configs live here and are **symlinked** back to the right place for a fully reproducible setup.

---

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
│   └── fix_nested.sh           # flattens accidental nested directories
│
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

## 📚 Documentation

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

### Notes

- The install script is **idempotent** — you can run it multiple times safely.
- Plugin installer (`install_zsh_plugins.sh`) runs automatically during linking but only installs missing plugins.
- Designed for fully reproducible setups on fresh machines.
