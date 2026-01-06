# Starship Prompt Integration Guide 🚀

This dotfiles setup includes **Starship**, a blazing-fast, customizable cross-shell prompt, as an alternative to Powerlevel10k. You can easily switch between the two!

---

## 📦 Installation

### Option 1: Using the Install Script (Recommended)

```bash
curl -sS https://starship.rs/install.sh | sh
```

### Option 2: Using Homebrew

```bash
brew install starship
```

### Option 3: Using Cargo

```bash
cargo install starship --locked
```

### Option 4: Package Managers

```bash
# Debian/Ubuntu
sudo apt install starship

# Arch Linux
sudo pacman -S starship

# Fedora
sudo dnf install starship
```

---

## 🔄 Switching Between Prompts

This setup includes a built-in toggle mechanism to switch between Starship and Powerlevel10k.

### Commands:

| Command           | Description                               |
| ----------------- | ----------------------------------------- |
| `toggle`          | Toggle between Starship and Powerlevel10k |
| `toggle starship` | Switch to Starship                        |
| `toggle p10k`     | Switch to Powerlevel10k                   |
| `check-prompt`    | Check which prompt is currently active    |

### Example Usage:

```bash
# Switch to Starship
toggle starship

# Apply changes (restart shell)
exec zsh

# Check current prompt
check-prompt

# Switch back to Powerlevel10k
toggle p10k
exec zsh
```

---

## ⚙️ Configuration

### Starship Configuration File

The Starship configuration is located at:

```
~/dot_files/config/starship.toml
```

This configuration is automatically symlinked to:

```
~/.config/starship.toml
```

### Customization

Edit the configuration file to customize your prompt:

```bash
nvim ~/dot_files/config/starship.toml
```

After making changes, restart your shell:

```bash
exec zsh
```

---

## 🎨 Features

The default Starship configuration includes:

✨ **Git Integration**

- Branch name and status
- Ahead/behind indicators
- Staged, modified, and untracked file counts

💻 **Language Support**

- Python (with virtualenv)
- Node.js
- Rust
- Go
- Lua
- Java
- And many more!

🐳 **Docker Context**

- Shows current Docker context

⏱️ **Command Duration**

- Shows execution time for long-running commands

🔋 **Battery Status**

- Battery level and charging status

🖥️ **System Information**

- Username and hostname
- OS icon
- Memory usage (optional)

---

## 🎯 Presets

Starship comes with several built-in presets. You can apply them using:

```bash
# View available presets
starship preset --list

# Apply a preset (example: Nerd Font Symbols)
starship preset nerd-font-symbols -o ~/.config/starship.toml

# Apply no-nerd-font preset (if you don't have Nerd Fonts)
starship preset no-nerd-font -o ~/.config/starship.toml

# Apply pastel powerline preset
starship preset pastel-powerline -o ~/.config/starship.toml
```

**Note:** Applying a preset will overwrite your current configuration. Back it up first!

---

## 🔧 Troubleshooting

### Starship Not Loading

1. **Check if Starship is installed:**

   ```bash
   starship --version
   ```

2. **Verify the configuration file exists:**

   ```bash
   ls -la ~/.config/starship.toml
   ```

3. **Check which prompt is active:**

   ```bash
   check-prompt
   ```

4. **Manually switch to Starship:**
   ```bash
   toggle starship
   exec zsh
   ```

### Symbols Not Displaying Correctly

If you see weird characters or boxes instead of symbols, you need to install a [Nerd Font](https://www.nerdfonts.com/):

```bash
# Download and install a Nerd Font (example: FiraCode)
# Then update your terminal's font settings

# Or use the no-nerd-font preset:
starship preset no-nerd-font -o ~/.config/starship.toml
```

### Performance Issues

If Starship feels slow, you can disable certain modules in `starship.toml`:

```toml
[package]
disabled = true

[nodejs]
disabled = true
```

---

## 📚 Additional Resources

- **Official Documentation:** https://starship.rs/
- **Configuration:** https://starship.rs/config/
- **Presets:** https://starship.rs/presets/
- **GitHub Repository:** https://github.com/starship/starship

---

## 🤝 How It Works

The integration uses a state file (`~/.config/prompt_theme`) to track which prompt is active:

1. **On shell startup**, `.zshrc` reads the state file
2. **If `starship`** is active:
   - Oh-My-Zsh theme is disabled
   - Starship is initialized
   - P10k instant prompt is skipped
3. **If `p10k`** is active:
   - P10k instant prompt loads
   - Oh-My-Zsh theme is set to Powerlevel10k
   - Starship initialization is skipped

This ensures **zero conflicts** and clean switching between prompts!

---

## 🎉 Benefits of Starship

- ⚡ **Blazing Fast** - Written in Rust for speed
- 🎨 **Beautiful** - Rich colors and symbols
- 🔧 **Highly Customizable** - TOML configuration
- 🔀 **Cross-Shell** - Works with Zsh, Bash, Fish, PowerShell, etc.
- 📦 **Minimal** - Only shows what you need
- 🚀 **Active Development** - Regular updates and improvements

---

_Enjoy your new prompt! 🚀_
