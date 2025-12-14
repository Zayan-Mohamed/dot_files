# Quick Start Guide 🚀

Get up and running with your dot_files in 5 minutes!

---

## 📦 Prerequisites

- **Git** - For cloning the repository
- **Zsh** - Your shell (most Linux distros have it)
- **Neovim** (optional but recommended)

---

## ⚡ Installation

### 1. Clone the Repository

```bash
git clone git@github.com:Zayan-Mohamed/dot_files.git ~/dot_files
cd ~/dot_files
```

### 2. Run the Installer

```bash
./scripts/install.sh
```

This will:

- Create symlinks for all configs in `~/.config/`
- Link dotfiles from `home/` to `~/`
- Install Zsh plugins (syntax highlighting, autosuggestions)
- Link scripts to `~/scripts/`

### 3. Restart Your Shell

```bash
exec zsh
```

Done! Your terminal is now configured. 🎉

---

## 🔍 What You Get

### Terminal Enhancements

- **Powerlevel10k** theme with beautiful prompts
- **Syntax highlighting** as you type
- **Autosuggestions** from history
- **Smart history** shared across sessions

### Modern Aliases

- `ll` - List files with icons (using eza)
- `cat` - Syntax highlighting (using bat, if installed)
- `gs` - Git status
- `glog` - Pretty git log
- Type `alias` to see all available shortcuts

### Neovim

- 80+ plugins pre-configured
- LSP support (Python, Lua, Bash, more)
- Fuzzy finding with FZF
- See [NVIM_STUDY_GUIDE.md](./NVIM_STUDY_GUIDE.md) for details

---

## 🛠️ Common Tasks

### Update Your Configs

After modifying any config file on your system:

```bash
~/scripts/update.sh
```

This syncs changes back into the repository.

### Check System Health

Verify all symlinks and dependencies:

```bash
~/scripts/health_check.sh
```

### Install Recommended Tools

See what modern CLI tools you're missing:

```bash
~/scripts/check_tools.sh
```

### Edit Configuration

#### Neovim

```bash
nvim ~/.config/nvim/init.lua
```

#### Zsh

```bash
nvim ~/.zshrc
source ~/.zshrc  # Reload immediately
```

#### Aliases

```bash
nvim ~/.aliases
source ~/.aliases  # Reload immediately
```

#### Git

```bash
nvim ~/.gitconfig
```

---

## 🎨 Customization

### Terminal Colors

Each terminal has its own config:

- **Alacritty**: `~/.config/alacritty/alacritty.toml`
- **Kitty**: `~/.config/kitty/kitty.conf`
- **Ghostty**: `~/.config/ghostty/config`

### Zsh Theme

To customize Powerlevel10k:

```bash
p10k configure
```

### Add Your Own Aliases

Edit `~/.aliases` and add:

```bash
alias myalias="my command"
```

Then reload:

```bash
source ~/.aliases
```

---

## 📚 Essential Commands

### File Navigation

```bash
ll          # List files with details
la          # List all files (including hidden)
lt          # List by modification time
..          # Go up one directory
...         # Go up two directories
```

### Git Shortcuts

```bash
gs          # git status (short)
ga          # git add
gc "msg"    # git commit -m "msg"
gp          # git push
gpl         # git pull
glog        # pretty git log
```

### Docker

```bash
dps         # docker ps
dcu         # docker-compose up -d
dcd         # docker-compose down
dcl         # docker-compose logs -f
```

### System

```bash
reload      # Reload zsh config
cleanup     # Clean apt packages
sysupdate   # Update system packages
```

---

## 🐛 Troubleshooting

### Symlinks Not Working?

Re-run the installer:

```bash
~/dot_files/scripts/install.sh
```

### Zsh Plugins Missing?

Install manually:

```bash
~/dot_files/scripts/install_zsh_plugins.sh
```

### Neovim Issues?

Check health:

```bash
nvim --headless "+checkhealth" "+qa"
```

### Permission Denied on Scripts?

Make them executable:

```bash
chmod +x ~/dot_files/scripts/*.sh
```

---

## 🔑 Key Files

| File                   | Purpose                   |
| ---------------------- | ------------------------- |
| `~/.zshrc`             | Zsh configuration         |
| `~/.aliases`           | Custom command aliases    |
| `~/.gitconfig`         | Git configuration         |
| `~/.config/nvim/`      | Neovim configuration      |
| `~/.config/alacritty/` | Alacritty terminal config |
| `~/.config/kitty/`     | Kitty terminal config     |

---

## 📖 Learn More

- **Neovim Guide**: [NVIM_STUDY_GUIDE.md](./NVIM_STUDY_GUIDE.md)
- **Enhancement Plan**: [ENHANCEMENT_PLAN.md](./ENHANCEMENT_PLAN.md)
- **Dependencies**: [DEPENDENCIES.md](./DEPENDENCIES.md)
- **Full README**: [README.md](./README.md)

---

## 🎯 Next Steps

1. **Explore aliases**: Type `alias` to see all shortcuts
2. **Learn Neovim**: Read the study guide
3. **Install tools**: Run `~/scripts/check_tools.sh`
4. **Customize**: Make it your own!

---

## 💡 Pro Tips

1. **Use fuzzy finding**: Press `Ctrl+R` to search history
2. **Tab completion**: Zsh has smart completions for almost everything
3. **Learn one alias per day**: Don't overwhelm yourself
4. **Check `which-key` in Neovim**: Press `<Space>` and wait to see commands
5. **Keep configs in sync**: Run `update.sh` regularly

---

## 🤝 Getting Help

- Check the health check: `~/scripts/health_check.sh`
- Read the documentation files
- Review git history to see what changed: `git log`

Happy coding! 🚀

---

_Generated: December 15, 2025_
