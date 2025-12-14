# Neovim Efficiency Study Guide

Based on your configuration at `/home/zayan/dot_files/config/nvim/`

---

## 📚 Table of Contents

1. [Core Keybindings](#core-keybindings)
2. [File Navigation & Search](#file-navigation--search)
3. [Text Editing Superpowers](#text-editing-superpowers)
4. [LSP & Code Intelligence](#lsp--code-intelligence)
5. [Git Integration](#git-integration)
6. [Buffer & Window Management](#buffer--window-management)
7. [Advanced Navigation](#advanced-navigation)
8. [Productivity Plugins](#productivity-plugins)

---

## 🎯 Core Keybindings

### Leader Key

Your **Leader key** is `<Space>` (default in most configs)

### Essential Shortcuts

| Key         | Action             | Description                           |
| ----------- | ------------------ | ------------------------------------- |
| `;`         | `:`                | Enter command mode (no Shift needed!) |
| `<leader>w` | Save file          | Quick save                            |
| `<leader>q` | Save & quit        | Quit current window                   |
| `<leader>Q` | Force quit all     | Quit nvim without saving              |
| `<F11>`     | Toggle spell check | In normal/insert mode                 |

### Quick Config Access

| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>ev` | Edit `init.lua` in new tab |
| `<leader>sv` | Reload config              |

---

## 🔍 File Navigation & Search

### FZF-Lua (Fuzzy Finder)

Your primary search tool - incredibly fast!

| Key          | Action                      |
| ------------ | --------------------------- |
| `<leader>ff` | Find files                  |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Search open buffers         |
| `<leader>fh` | Search help tags            |
| `<leader>ft` | Search buffer tags          |

**Pro Tip:** Use FZF for everything! It's faster than navigating manually.

### Nvim-Tree (File Explorer)

| Key        | Action           |
| ---------- | ---------------- |
| `<Space>s` | Toggle file tree |

Inside nvim-tree:

- Press `?` to see all commands
- `a` - Create file/folder
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste

---

## ✨ Text Editing Superpowers

### Smart Line Operations

| Key        | Action                                  |
| ---------- | --------------------------------------- |
| `<Space>o` | Insert blank line below (stay in place) |
| `<Space>O` | Insert blank line above (stay in place) |
| `<Alt-j>`  | Move current line down                  |
| `<Alt-k>`  | Move current line up                    |
| `J`        | Join lines (cursor stays put)           |
| `gJ`       | Join lines without space (cursor stays) |

### Smart Navigation

| Key | Action                             |
| --- | ---------------------------------- |
| `H` | Go to start of line (like `^`)     |
| `L` | Go to end of line (like `g_`)      |
| `j` | Move down (respects wrapped lines) |
| `k` | Move up (respects wrapped lines)   |

### Vim-Sandwich (Surround Text)

Better than vim-surround! Map: `s` is disabled (use `cl` instead)

**Add surroundings:**

- `sa{motion}{char}` - Add surrounding
- Example: `saiw"` - Surround inner word with quotes
- Example: `sa2w(` - Surround 2 words with parentheses

**Delete surroundings:**

- `sd{char}` - Delete surrounding
- Example: `sd"` - Delete surrounding quotes
- Example: `sd)` - Delete surrounding parentheses

**Replace surroundings:**

- `sr{old}{new}` - Replace surrounding
- Example: `sr"'` - Replace double quotes with single quotes
- Example: `sr)]` - Replace `)` with `]`

### Vim-Commentary (Comments)

| Key            | Action                         |
| -------------- | ------------------------------ |
| `gcc`          | Toggle comment on current line |
| `gc{motion}`   | Toggle comment on motion       |
| `gc` in visual | Comment selection              |

Examples:

- `gcap` - Comment a paragraph
- `gc2j` - Comment current + 2 lines below

### Better Change/Delete

| Key               | Action                     | Note                      |
| ----------------- | -------------------------- | ------------------------- |
| `c`, `C`, `cc`    | Change without yanking     | Doesn't pollute registers |
| `<leader><space>` | Remove trailing whitespace | Clean up files            |

### Paste Superpowers

| Key           | Action                             |
| ------------- | ---------------------------------- |
| `<leader>p`   | Paste below current line           |
| `<leader>P`   | Paste above current line           |
| `<leader>v`   | Reselect last pasted text          |
| `p` in visual | Paste without overwriting register |

### Yanky (Yank History)

Enhanced clipboard with history!

| Key  | Action                               |
| ---- | ------------------------------------ |
| `p`  | Smart paste after                    |
| `P`  | Smart paste before                   |
| `[y` | Cycle to previous yank (after paste) |
| `]y` | Cycle to next yank (after paste)     |

**Workflow:**

1. Paste something: `p`
2. Not what you wanted? Press `[y` to cycle through yank history!

### Visual Mode Enhancements

| Key       | Action                         |
| --------- | ------------------------------ |
| `<`       | Indent left (stay in visual)   |
| `>`       | Indent right (stay in visual)  |
| `<Alt-j>` | Move selection down            |
| `<Alt-k>` | Move selection up              |
| `$`       | Go to end (exclude whitespace) |

### Insert Mode Productivity

| Key        | Action                    |
| ---------- | ------------------------- |
| `<Ctrl-u>` | Uppercase current word    |
| `<Ctrl-t>` | Title case current word   |
| `<Ctrl-a>` | Go to line start          |
| `<Ctrl-e>` | Go to line end            |
| `<Ctrl-d>` | Delete character forward  |
| `<Alt-;>`  | Add semicolon at line end |

**Undo break points:** `, . ! ? ; :` create undo points automatically

---

## 🧠 LSP & Code Intelligence

### Code Navigation

| Key        | Action                         |
| ---------- | ------------------------------ |
| `gd`       | Go to definition (smart dedup) |
| `<Ctrl-]>` | Go to definition (alternative) |
| `K`        | Show hover documentation       |
| `<Ctrl-k>` | Show signature help            |

### Code Actions

| Key         | Action           |
| ----------- | ---------------- |
| `<Space>rn` | Rename variable  |
| `<Space>ca` | Code action menu |

### Workspace Management

| Key         | Action                  |
| ----------- | ----------------------- |
| `<Space>wa` | Add workspace folder    |
| `<Space>wr` | Remove workspace folder |
| `<Space>wl` | List workspace folders  |

### Glance (Quick Reference)

See definitions/references in a popup without losing position

### LSP Servers Enabled:

- **Python**: Pyright (type checking), Ruff (linting)
- **Lua**: lua_ls
- **Bash**: bashls
- **Vim**: vimls
- **YAML**: yamlls

---

## 🌿 Git Integration

### Gitsigns (Inline Git)

| Key          | Action             |
| ------------ | ------------------ |
| `]c`         | Next git hunk      |
| `[c`         | Previous git hunk  |
| `<leader>hp` | Preview hunk       |
| `<leader>hb` | Blame current line |

### Vim-Fugitive (Git Commands)

Powerful git wrapper - use `:Git` or `:G` prefix:

**Common commands:**

- `:Git status` or `:G` - Git status
- `:Git commit` - Commit
- `:Git push` - Push
- `:Git pull` - Pull
- `:Git diff` - Diff
- `:Git blame` - Blame

### Git-Conflict (Merge Conflicts)

Visual merge conflict resolution

### Diffview

| Command                | Action         |
| ---------------------- | -------------- |
| `:DiffviewOpen`        | Open diff view |
| `:DiffviewFileHistory` | File history   |

### GitLinker

Generate shareable links to code on GitHub/GitLab

---

## 📂 Buffer & Window Management

### Buffer Navigation

| Key         | Action                              |
| ----------- | ----------------------------------- |
| `gb`        | Go to next buffer                   |
| `gB`        | Go to previous buffer               |
| `\d`        | Delete current buffer (keep window) |
| `\D`        | Delete all other buffers            |
| `<leader>y` | Yank entire buffer                  |

### Bufferline

Visual buffer tabs at the top - click or use `gb`/`gB`

### Window Navigation

| Key       | Action               |
| --------- | -------------------- |
| `<Left>`  | Move to left window  |
| `<Right>` | Move to right window |
| `<Up>`    | Move to window above |
| `<Down>`  | Move to window below |

### Window Splits

| Command   | Action                       |
| --------- | ---------------------------- |
| `:split`  | Horizontal split             |
| `:vsplit` | Vertical split               |
| `\x`      | Close quickfix/location list |

### Working Directory

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `<leader>cd` | Change to current file's directory |

---

## 🚀 Advanced Navigation

### Hop.nvim (EasyMotion Alternative)

Jump anywhere on screen in 2 keystrokes!

| Key | Action                              |
| --- | ----------------------------------- |
| `f` | Hop to any position (2-char search) |

**How it works:**

1. Press `f`
2. Type 2 characters
3. See labels appear
4. Type the label to jump

This replaces the default `f` (find character) - super powerful!

### Nvim-UFO (Code Folding)

Smart code folding using LSP/Treesitter

| Key  | Action                   |
| ---- | ------------------------ |
| `zR` | Open all folds           |
| `zM` | Close all folds          |
| `za` | Toggle fold under cursor |
| `zo` | Open fold                |
| `zc` | Close fold               |

### HLSlens (Search Enhancement)

Better search highlighting with position indicators

### Text Objects

Custom text objects:

- `iu` - URL text object (e.g., `ciu` to change URL)
- `iB` - Entire buffer text object (e.g., `yiB` to yank buffer)

### Targets.vim

Enhanced text objects:

- `ci)` works even when cursor is not inside
- `cin)` - next parentheses
- `cil)` - last parentheses
- Works with: `()`, `[]`, `{}`, `''`, `""`, ` `` `, `<>`, tags

---

## 🔧 Productivity Plugins

### Nvim-Cmp (Autocompletion)

Smart autocompletion with multiple sources:

- LSP completions
- Buffer words
- File paths
- Snippets (UltiSnips)

**In completion menu:**

- `<Tab>` / `<S-Tab>` - Navigate (likely)
- `<CR>` - Confirm
- `<Esc>` - Cancel

### UltiSnips (Snippets)

Code snippets for faster coding

- Located in: `my_snippets/`
- Trigger with autocompletion or custom keys

### Which-Key

Shows available keybindings automatically!

- Wait 500ms after pressing a key to see options
- Example: Press `<Space>` and wait to see all leader commands

### Mini.indentscope

Visual indentation guides with scope highlighting

### Nvim-Lightbulb

Shows 💡 when code actions are available

### Dashboard

Custom start screen with quick actions

### Lualine

Beautiful statusline showing:

- Mode
- File info
- Git branch
- LSP status
- Diagnostics

### Nvim-Notify

Fancy notifications - see history with `:Notifications`

### Asyncrun

Run async commands:

```vim
:AsyncRun <command>
```

### Nvim-Treesitter

Advanced syntax highlighting and text objects

- Much better than regex-based highlighting
- Powers smart selections and folds

### Nvim-Autopairs

Automatic bracket/quote pairing

### Better-Escape

Smarter `jk` or `jj` to escape insert mode (check your config)

### Tabular

Align text by a pattern:

```vim
:Tabularize /<pattern>
```

Example: `:Tabularize /=` aligns on `=`

### Vim-Mundo

Visualize undo tree:

```vim
:MundoToggle
```

### Vim-Obsession

Session management - save and restore sessions

### Vim-Eunuch

Unix file operations:

- `:Delete` - Delete file and buffer
- `:Move` - Move/rename file
- `:Rename` - Rename file
- `:Chmod` - Change permissions

### Vim-Repeat

Makes plugin operations repeatable with `.`

### Nvim-Colorizer

Highlights color codes in their actual colors

### Whitespace.nvim

Highlight trailing whitespace

---

## 🎓 Learning Path

### Week 1: Core Efficiency

- [ ] Use `;` instead of `:` for commands
- [ ] Master `<leader>w`, `<leader>q` for file operations
- [ ] Use `H` and `L` instead of `^` and `$`
- [ ] Practice `<Space>o` and `<Space>O` for line insertion
- [ ] Try `<Alt-j>` and `<Alt-k>` for moving lines

### Week 2: Search & Navigation

- [ ] Use `<leader>ff` for all file opening
- [ ] Master `<leader>fg` for finding text
- [ ] Learn `f` (hop) for quick jumps
- [ ] Use `gb`/`gB` for buffer navigation
- [ ] Practice `<Space>s` for file tree

### Week 3: Text Objects & Editing

- [ ] Master vim-sandwich: `sa`, `sd`, `sr`
- [ ] Use `gcc` for commenting
- [ ] Practice `ci"`, `ca(`, `dit` (targets.vim)
- [ ] Learn visual indent: `<` and `>`
- [ ] Use yanky's `[y` and `]y` for yank history

### Week 4: LSP & Git

- [ ] Use `gd` for go-to-definition
- [ ] Master `K` for documentation
- [ ] Learn `<Space>rn` for renaming
- [ ] Use `]c` and `[c` for git hunks
- [ ] Try `:Git` commands for version control

### Week 5: Advanced Workflows

- [ ] Master quickfix/location list: `\x` to close
- [ ] Use `<leader>cd` to change directory
- [ ] Learn buffer management: `\d` and `\D`
- [ ] Practice folding: `za`, `zR`, `zM`
- [ ] Explore `:MundoToggle` for undo visualization

### Week 6: Power User

- [ ] Customize your own mappings
- [ ] Create custom snippets in `my_snippets/`
- [ ] Learn `:Tabularize` for alignment
- [ ] Use `:AsyncRun` for background tasks
- [ ] Master your LSP code actions

---

## 💡 Pro Tips

### 1. **Embrace Fuzzy Finding**

Stop navigating file trees! `<leader>ff` is your best friend. Type a few characters and fuzzy match. Same with `<leader>fg` for content.

### 2. **Think in Motions**

Neovim is a language:

- `d` = delete
- `c` = change
- `y` = yank
- Combine with: `iw` (inner word), `ap` (a paragraph), `i"` (inside quotes)

Examples:

- `ciw` = change inner word
- `dap` = delete a paragraph
- `yi"` = yank inside quotes

### 3. **Use Counts**

Prefix commands with numbers:

- `3j` = move down 3 lines
- `2dw` = delete 2 words
- `5<Space>o` = insert 5 blank lines

### 4. **Stay in Normal Mode**

The more you stay in normal mode, the more efficient you are. Use `<Ctrl-u>`, `<Ctrl-t>` in insert mode for quick edits, but return to normal.

### 5. **Learn One Thing at a Time**

Don't try to learn everything at once. Pick one new keybinding per day.

### 6. **Use Which-Key**

When stuck, press your leader key and wait. Which-key shows available commands!

### 7. **Read Documentation**

- `:help <topic>` is your friend
- `:help user-manual` - comprehensive guide
- `:Telescope help_tags` - searchable help

### 8. **Check Your Plugins**

Many plugins have their own `:PluginName` commands. Explore them:

- `:FzfLua` - see all FZF commands
- `:Git` - git commands
- `:Lazy` - plugin manager UI

---

## 🔑 Essential Muscle Memory

These should become automatic:

1. **Save & Quit**: `<leader>w` then `<leader>q`
2. **Find File**: `<leader>ff` (then type a few chars)
3. **Search in Files**: `<leader>fg` (grep)
4. **Go to Definition**: `gd`
5. **Show Docs**: `K`
6. **Comment Line**: `gcc`
7. **Delete Buffer**: `\d`
8. **Jump Anywhere**: `f` + 2 chars + label
9. **Next/Prev Buffer**: `gb` / `gB`
10. **Toggle File Tree**: `<Space>s`

---

## 📖 Additional Resources

### Neovim Basics

- `:help user-manual` - Complete user manual
- `:Tutor` - Interactive tutorial (if available)
- https://neovim.io/doc/ - Official docs

### Your Config

- Main config: `~/.config/nvim/init.lua`
- Mappings: `~/.config/nvim/lua/mappings.lua`
- Plugin configs: `~/.config/nvim/lua/config/`

### Plugin Documentation

- `:Lazy` - Plugin manager UI
- Each plugin has `:help plugin-name` documentation

---

## 🎯 Practice Exercises

### Exercise 1: Basic Editing

1. Open a file: `<leader>ff`
2. Jump to a word: `f` + first 2 letters
3. Change it: `ciw` + type new word
4. Comment it: `gcc`
5. Save: `<leader>w`

### Exercise 2: Refactoring

1. Find a variable: `<leader>fg` + search term
2. Go to definition: `gd`
3. Rename it: `<Space>rn`
4. See references: Check LSP features
5. Save all: `<leader>w`

### Exercise 3: Git Workflow

1. Make changes to a file
2. See diff: `]c` and `[c` to navigate hunks
3. Preview: `<leader>hp`
4. Stage and commit: `:Git commit`
5. Push: `:Git push`

### Exercise 4: Multi-Buffer

1. Open 4 files: `<leader>ff` (repeat)
2. Navigate: `gb` and `gB`
3. Close unwanted: `\d`
4. Split window: `:vsplit`
5. Navigate splits: Arrow keys
6. Close splits: `:q`

---

## 🐛 Troubleshooting

### LSP Not Working?

1. Check if LSP is enabled: `:LspInfo`
2. Check servers: `:checkhealth`
3. Verify executables are installed (pyright, ruff, lua-language-server, etc.)

### Keybinding Not Working?

1. Check for conflicts: `:verbose map <key>`
2. Check which-key: Press key and wait
3. Review `lua/mappings.lua`

### Plugin Issues?

1. Open Lazy UI: `:Lazy`
2. Update plugins: `U` in Lazy UI
3. Check health: `:checkhealth`

---

## 🚀 Next Steps

1. **Print this guide** or keep it open in a split
2. **Pick 3 keybindings** to learn this week
3. **Use them consciously** until they become automatic
4. **Add your own** mappings for your workflow
5. **Teach someone else** - best way to solidify learning

Remember: **Efficiency comes with practice!** Don't rush, be patient, and enjoy the journey to Neovim mastery.

---

_Generated from your nvim config at `/home/zayan/dot_files/config/nvim/`_
_Last updated: December 14, 2025_
