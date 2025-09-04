# dot_files

My personal Linux configuration files (terminals, editors, and tools).

This repo manages everything in `~/.config` and my dotfiles in `~`.  
Configs live here and are symlinked back to the right place.

---

## Setup

Clone into your home directory:

```bash
git clone git@github.com:yourusername/dot_files.git ~/dot_files
cd ~/dot_files
```
```
dot_files/
│
├── config/                 # mirrors ~/.config
│   ├── alacritty/
│   ├── kitty/
│   ├── wezterm/
│   ├── ghostty/
│   ├── nvim/
│   └── ...
│
├── home/                   # for dotfiles in ~ (not ~/.config)
│   ├── .bashrc
│   ├── .zshrc
│   ├── .gitconfig
│   └── ...
│
├── scripts/                # helper scripts
│   ├── install.sh          # main bootstrap: creates symlinks
│   ├── update.sh           # pulls new changes, re-links
│   └── fix_nested.sh       # flattens accidental nested dirs
│
└── README.md
```
