# Neovim Keybindings Guide 🎯

Complete reference for all keybindings in your Neovim configuration.

---

## 🔑 Leader Key

**Leader Key: `,` (comma)**

The leader key is your main prefix for custom commands. Press `,` followed by another key.

---

## 🔍 Search & Find

### File Search (FZF-Lua)

| Keybinding | Description                   | Command             |
| ---------- | ----------------------------- | ------------------- |
| `,ff`      | **Find files** (fuzzy search) | `:FzfLua files`     |
| `,fg`      | **Live grep** (search text)   | `:FzfLua live_grep` |
| `,fb`      | Find in open buffers          | `:FzfLua buffers`   |
| `,fr`      | Recent files (oldfiles)       | `:FzfLua oldfiles`  |
| `,fh`      | Search help tags              | `:FzfLua helptags`  |
| `,ft`      | Search buffer tags            | `:FzfLua btags`     |

### Search in Current Buffer

| Keybinding | Description                | Mode   |
| ---------- | -------------------------- | ------ |
| `/`        | Search forward             | Normal |
| `?`        | Search backward            | Normal |
| `n`        | Next search result         | Normal |
| `N`        | Previous search result     | Normal |
| `*`        | Search word under cursor   | Normal |
| `#`        | Search word under cursor ← | Normal |

### Enhanced Search (hlslens plugin)

- Shows match count and index while searching
- Auto-enabled for `*`, `#`, `n`, `N` keys

---

## 📁 File Management

### File Explorer (nvim-tree)

| Keybinding | Description      |
| ---------- | ---------------- |
| `<space>s` | Toggle file tree |

Inside nvim-tree:

- `Enter` - Open file/folder
- `a` - Create file/folder
- `d` - Delete file/folder
- `r` - Rename file/folder
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `?` - Show help

---

## 💾 Save & Quit

| Keybinding | Description                    |
| ---------- | ------------------------------ |
| `,w`       | **Save current file**          |
| `,q`       | **Save & quit current window** |
| `,Q`       | **Quit all (force)**           |
| `:w`       | Save                           |
| `:q`       | Quit                           |
| `:wq`      | Save & quit                    |
| `:qa`      | Quit all                       |

---

## 📝 Buffer Management

| Keybinding | Description               |
| ---------- | ------------------------- |
| `,fb`      | List open buffers (fuzzy) |
| `\d`       | Delete current buffer     |
| `\D`       | Delete all other buffers  |
| `gb`       | Go to next buffer         |
| `gB`       | Go to previous buffer     |

---

## 📋 Copy, Paste & Edit

| Keybinding | Description                | Mode   |
| ---------- | -------------------------- | ------ |
| `,y`       | Copy entire buffer         | Normal |
| `,p`       | Paste below current line   | Normal |
| `,P`       | Paste above current line   | Normal |
| `,v`       | Reselect last pasted text  | Normal |
| `c`        | Change (without yanking)   | Normal |
| `p`        | Paste (in visual mode)     | Visual |
| `,<space>` | Remove trailing whitespace | Normal |

---

## 🧭 Navigation

### Basic Movement

| Keybinding | Description             |
| ---------- | ----------------------- |
| `h/j/k/l`  | Left/Down/Up/Right      |
| `H`        | Go to start of line     |
| `L`        | Go to end of line       |
| `w`        | Next word               |
| `b`        | Previous word           |
| `{` / `}`  | Previous/Next paragraph |
| `gg`       | Go to first line        |
| `G`        | Go to last line         |

### Window Navigation

| Keybinding      | Description       |
| --------------- | ----------------- |
| `←` / `<left>`  | Move to left win  |
| `→` / `<right>` | Move to right win |
| `↑` / `<up>`    | Move to up win    |
| `↓` / `<down>`  | Move to down win  |

### Jump Navigation (Hop)

| Keybinding | Description            |
| ---------- | ---------------------- |
| `f`        | Quick jump to any char |

---

## 🔧 LSP (Language Server)

### Code Navigation

| Keybinding | Description              |
| ---------- | ------------------------ |
| `gd`       | **Go to definition**     |
| `<C-]>`    | Go to definition (alt)   |
| `K`        | Show hover documentation |
| `<C-k>`    | Show signature help      |

### Code Actions

| Keybinding  | Description          |
| ----------- | -------------------- |
| `<space>rn` | Rename variable      |
| `<space>ca` | Code action          |
| `<space>wa` | Add workspace folder |
| `<space>wr` | Remove workspace     |
| `<space>wl` | List workspace       |

---

## 🎨 Visual Mode

| Keybinding | Description                |
| ---------- | -------------------------- |
| `v`        | Enter visual mode          |
| `V`        | Enter visual line mode     |
| `<C-v>`    | Enter visual block mode    |
| `<`        | Shift left (stays in vis)  |
| `>`        | Shift right (stays in vis) |
| `<A-j>`    | Move selection down        |
| `<A-k>`    | Move selection up          |

---

## 🔄 Git Integration

| Keybinding | Description         | Plugin       |
| ---------- | ------------------- | ------------ |
| Various    | Git status, commit  | vim-fugitive |
| Various    | Git signs in gutter | gitsigns     |

---

## 📖 Text Objects & Editing

### Custom Text Objects

| Keybinding | Description     |
| ---------- | --------------- |
| `iu`       | URL text object |
| `iB`       | Entire buffer   |

### Surround (vim-sandwich)

| Keybinding         | Description         |
| ------------------ | ------------------- |
| `sa{motion}{char}` | Add surrounding     |
| `sd{char}`         | Delete surrounding  |
| `sr{old}{new}`     | Replace surrounding |

### Comment

| Keybinding | Description    | Mode          |
| ---------- | -------------- | ------------- |
| `gc`       | Toggle comment | Normal/Visual |
| `gcc`      | Comment line   | Normal        |

---

## ⚡ Quick Actions

| Keybinding | Description              |
| ---------- | ------------------------ |
| `;`        | Enter command mode (`:`) |
| `<F11>`    | Toggle spell check       |
| `<Esc>`    | Close floating windows   |
| `J`        | Join lines (no move)     |
| `,cd`      | Change to file directory |
| `,cb`      | Blink cursor (find it)   |

---

## 📝 Config Management

| Keybinding | Description     |
| ---------- | --------------- |
| `,ev`      | Edit init.lua   |
| `,sv`      | Reload init.lua |

---

## 🎯 Special Modes

### Insert Mode Shortcuts

| Keybinding | Description                 |
| ---------- | --------------------------- |
| `<C-u>`    | UPPERCASE word under cursor |
| `<C-t>`    | Title Case word             |
| `<C-a>`    | Go to line start            |
| `<C-e>`    | Go to line end              |
| `<C-d>`    | Delete char right           |
| `<A-;>`    | Add semicolon at line end   |

### Command Mode

| Keybinding | Description      |
| ---------- | ---------------- |
| `<C-a>`    | Go to line start |

---

## 🔌 Plugin Shortcuts

### Lazy (Plugin Manager)

| Command | Description     |
| ------- | --------------- |
| `:pi`   | Install plugins |
| `:pud`  | Update plugins  |
| `:pc`   | Clean plugins   |
| `:ps`   | Sync plugins    |

### Vista (Tag Viewer)

| Keybinding | Description  |
| ---------- | ------------ |
| `<space>t` | Toggle Vista |

### Which-Key

Press `<space>` or `,` and wait ~500ms to see available keybindings!

---

## 💡 Pro Tips

1. **Find files quickly**: `,ff` is your best friend
2. **Search in project**: `,fg` for live grep (searches file contents)
3. **Recent files**: `,fr` to quickly reopen files
4. **Help tags**: `,fh` to search Neovim help
5. **Explore keybindings**: Press `<space>` or `,` and wait for which-key popup

### Common Workflows

**Search for a word in all files:**

```
,fg
<type your search term>
<Enter>
```

**Find and open a file:**

```
,ff
<type part of filename>
<Enter>
```

**Navigate code:**

```
gd          (go to definition)
K           (read documentation)
<C-o>       (jump back)
```

---

## 🔍 Quick Reference Card

### Most Used Keybindings

```
SEARCH & FIND        SAVE & QUIT         NAVIGATION
,ff - Find files     ,w - Save           gd - Go to definition
,fg - Grep text      ,q - Save & quit    H/L - Line start/end
,fb - Buffers        ,Q - Quit all       f - Hop jump
,fr - Recent files   \d - Close buffer   gb/gB - Next/prev buffer

CODE EDITING         WINDOWS             PLUGINS
gc - Comment         ← → ↑ ↓ - Switch   <space>s - File tree
K - Documentation    ,cd - Change dir     ,ev - Edit config
<space>rn - Rename   <space>t - Vista    ,sv - Reload config
```

---

## 📚 Learn More

- **Neovim Basics**: `:help` or `:Tutor` in Neovim
- **FZF-Lua**: `:help fzf-lua`
- **LSP**: `:help lsp`
- **Plugin Docs**: Most plugins have `:help <plugin-name>`

---

**Leader Key Reminder: `,` (comma)**

Press `,` then wait a moment to see available commands via which-key!

---

_Last Updated: December 19, 2025_
