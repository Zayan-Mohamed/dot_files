# Dependencies 📦

Complete list of required and optional dependencies for this dot_files configuration.

---

## ✅ Required (Essential)

These tools are required for basic functionality:

| Tool                | Purpose         | Installation                  |
| ------------------- | --------------- | ----------------------------- |
| **Git**             | Version control | `sudo apt install git`        |
| **Zsh**             | Shell           | `sudo apt install zsh`        |
| **Oh My Zsh**       | Zsh framework   | [ohmyz.sh](https://ohmyz.sh/) |
| **Neovim ≥ 0.11.3** | Text editor     | `snap install nvim --classic` |

---

## 🎨 Highly Recommended

These enhance your experience significantly:

### Fonts

| Tool                         | Purpose                 | Installation                                   |
| ---------------------------- | ----------------------- | ---------------------------------------------- |
| **Nerd Font**                | Icons in terminal/nvim  | See [Nerd Fonts](https://www.nerdfonts.com/)   |
| **JetBrains Mono Nerd Font** | Recommended coding font | `apt install fonts-jetbrains-mono` or download |

### Zsh Plugins

| Plugin                           | Purpose                | Installation                   |
| -------------------------------- | ---------------------- | ------------------------------ |
| **Powerlevel10k**                | Beautiful prompt theme | Via Oh My Zsh                  |
| **zsh-autosuggestions**          | Command suggestions    | Auto-installed by `install.sh` |
| **zsh-syntax-highlighting**      | Syntax highlighting    | Auto-installed by `install.sh` |
| **zsh-history-substring-search** | Better history search  | Auto-installed by `install.sh` |
| **zsh-autopair**                 | Auto-close brackets    | Auto-installed by `install.sh` |

---

## 🚀 Modern CLI Tools (Optional but Awesome)

These replace traditional Unix tools with modern alternatives:

### File Operations

| Tool             | Replaces | Purpose                        | Installation            |
| ---------------- | -------- | ------------------------------ | ----------------------- |
| **eza**          | `ls`     | Better file listing with icons | `cargo install eza`     |
| **bat**          | `cat`    | Cat with syntax highlighting   | `cargo install bat`     |
| **fd**           | `find`   | Faster, simpler find           | `cargo install fd-find` |
| **ripgrep (rg)** | `grep`   | Much faster grep               | `cargo install ripgrep` |

### System Monitoring

| Tool      | Replaces | Purpose                    | Installation            |
| --------- | -------- | -------------------------- | ----------------------- |
| **htop**  | `top`    | Interactive process viewer | `apt install htop`      |
| **btop**  | `top`    | Modern resource monitor    | `snap install btop`     |
| **procs** | `ps`     | Modern process viewer      | `cargo install procs`   |
| **dust**  | `du`     | Better disk usage analyzer | `cargo install du-dust` |
| **duf**   | `df`     | Better disk usage display  | `apt install duf`       |

### Development Tools

| Tool        | Purpose              | Installation              |
| ----------- | -------------------- | ------------------------- |
| **fzf**     | Fuzzy finder         | `apt install fzf`         |
| **delta**   | Better git diff      | `cargo install git-delta` |
| **lazygit** | Terminal UI for git  | `apt install lazygit`     |
| **jq**      | JSON processor       | `apt install jq`          |
| **tldr**    | Simplified man pages | `npm install -g tldr`     |
| **zoxide**  | Smarter cd command   | `cargo install zoxide`    |

---

## 🔧 Build Tools

Required for installing many modern CLI tools:

| Tool                | Purpose                        | Installation                                                      |
| ------------------- | ------------------------------ | ----------------------------------------------------------------- |
| **Rust/Cargo**      | Build tool (for Rust packages) | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
| **Node.js/npm**     | JavaScript runtime             | `apt install nodejs npm`                                          |
| **Python 3**        | Python runtime                 | Usually pre-installed                                             |
| **build-essential** | C/C++ compiler                 | `apt install build-essential`                                     |

---

## 🐍 Python Development

If using Python features in Neovim:

| Tool                | Purpose                    | Installation                                                    |
| ------------------- | -------------------------- | --------------------------------------------------------------- |
| **pyright**         | Python LSP server          | `npm install -g pyright`                                        |
| **ruff**            | Python linter              | `pip install ruff`                                              |
| **conda/miniconda** | Python environment manager | See [Miniconda](https://docs.conda.io/en/latest/miniconda.html) |

---

## 📝 Neovim LSP Servers

Language servers for code intelligence:

| Language   | Server               | Installation                                                         |
| ---------- | -------------------- | -------------------------------------------------------------------- |
| **Python** | pyright, ruff        | `npm install -g pyright && pip install ruff`                         |
| **Lua**    | lua-language-server  | Download from [GitHub](https://github.com/LuaLS/lua-language-server) |
| **Bash**   | bash-language-server | `npm install -g bash-language-server`                                |
| **YAML**   | yaml-language-server | `npm install -g yaml-language-server`                                |
| **Vim**    | vim-language-server  | `npm install -g vim-language-server`                                 |

---

## 🐳 Container Development

If using Docker:

| Tool               | Purpose                       | Installation                                              |
| ------------------ | ----------------------------- | --------------------------------------------------------- |
| **Docker**         | Container runtime             | [Docker Install](https://docs.docker.com/engine/install/) |
| **Docker Compose** | Multi-container orchestration | Usually included with Docker                              |

---

## 🌐 Optional Terminal Emulators

Choose one (or use all three!):

| Terminal      | Features                  | Config Location        |
| ------------- | ------------------------- | ---------------------- |
| **Alacritty** | GPU-accelerated, fast     | `~/.config/alacritty/` |
| **Kitty**     | GPU-accelerated, advanced | `~/.config/kitty/`     |
| **Ghostty**   | Modern, native            | `~/.config/ghostty/`   |

---

## 📊 Quick Install Commands

### Install All at Once (Requires Cargo)

```bash
# Modern CLI tools (Rust-based)
cargo install eza bat fd-find ripgrep procs du-dust git-delta zoxide

# System tools
sudo apt install fzf htop duf jq lazygit

# LSP servers
npm install -g pyright bash-language-server yaml-language-server vim-language-server tldr
pip install ruff
```

### Check What You're Missing

```bash
~/scripts/check_tools.sh
```

---

## 🔍 Dependency Checks

### Verify Neovim Plugins

```bash
nvim --headless "+checkhealth" "+qa"
```

### Verify Shell Setup

```bash
~/scripts/health_check.sh
```

### Verify Tool Availability

```bash
~/scripts/check_tools.sh
```

---

## 📦 Version Requirements

### Minimum Versions

- **Neovim**: ≥ 0.11.3
- **Git**: ≥ 2.0
- **Zsh**: ≥ 5.0
- **Python**: ≥ 3.8 (for LSP)
- **Node.js**: ≥ 16.0 (for LSP)

### Recommended Versions

- **Neovim**: Latest stable
- **Git**: Latest stable
- **Zsh**: Latest stable

---

## 🎓 Learning More

### Tool Documentation

- **eza**: https://github.com/eza-community/eza
- **bat**: https://github.com/sharkdp/bat
- **fd**: https://github.com/sharkdp/fd
- **ripgrep**: https://github.com/BurntSushi/ripgrep
- **fzf**: https://github.com/junegunn/fzf
- **Neovim**: https://neovim.io/doc/

### Package Managers

- **Cargo** (Rust): https://doc.rust-lang.org/cargo/
- **npm** (Node): https://www.npmjs.com/
- **pip** (Python): https://pip.pypa.io/

---

## 💡 Pro Tips

1. **Use Cargo for modern tools**: Most Rust-based tools are fast and well-maintained
2. **Install LSP servers incrementally**: Only install for languages you use
3. **Check before installing**: Use `command -v <tool>` to check if installed
4. **Keep tools updated**: Run `cargo install-update -a` periodically (requires cargo-update)
5. **Use package managers**: Prefer apt/snap/cargo over manual installation

---

## 🐛 Common Issues

### "command not found" after cargo install

**Solution**: Add `~/.cargo/bin` to PATH (already in `.zshrc`)

### LSP not working in Neovim

**Solution**:

1. Check if LSP server is installed: `which <server-name>`
2. Run `:checkhealth` in Neovim
3. Install missing servers

### Nerd Font icons not showing

**Solution**:

1. Install a Nerd Font
2. Configure terminal to use it
3. Check configs: `alacritty.toml`, `kitty.conf`, `ghostty/config`

---

## 📞 Getting Help

Run diagnostic scripts:

```bash
~/scripts/health_check.sh    # Check symlinks and essential tools
~/scripts/check_tools.sh      # Check optional tools
nvim --headless "+checkhealth" "+qa"  # Check Neovim setup
```

---

_Last updated: December 15, 2025_
