# Modern CLI Tools

A reference for the productivity tools installed in this dotfiles setup. These are
fast, modern replacements for classic Unix utilities, plus a few TUIs that speed up
everyday Git/Docker/file workflows.

All were installed via Homebrew (`/home/linuxbrew/.linuxbrew`), except `gh-dash`
which is a `gh` CLI extension. The aliases and integrations referenced below live in
[`shell/linux_aliases.sh`](shell/linux_aliases.sh), [`home/.zshrc`](home/.zshrc),
and [`home/.gitconfig`](home/.gitconfig).

> **Install / update everything again:**
> ```sh
> brew install bat fd git-delta dust procs sd navi yazi lazydocker
> gh extension install dlvhdr/gh-dash
> ```

---

## Quick reference

| Tool         | Replaces / adds      | One-liner                                   | Handy alias    |
|--------------|----------------------|---------------------------------------------|----------------|
| `bat`        | `cat`                | Syntax-highlighted file viewer with paging  | `cat`, `catt`  |
| `fd`         | `find`               | Fast, intuitive file finder                 | `find`         |
| `delta`      | `git diff` pager     | Beautiful, navigable git diffs              | (auto in git)  |
| `dust`       | `du`                 | Visual disk-usage tree                       | `du`           |
| `procs`      | `ps`                 | Modern, colored process viewer              | `ps`           |
| `sd`         | `sed` (find/replace) | Dead-simple search & replace                | `subst`        |
| `navi`       | —                    | Interactive command cheatsheets (Ctrl-G)    | —              |
| `yazi`       | file manager         | Blazing-fast terminal file manager          | `y`            |
| `lazydocker` | docker CLI           | TUI dashboard for Docker                     | `lzd`          |
| `gh-dash`    | —                    | TUI dashboard for GitHub PRs & issues       | `ghd`          |

---

## bat — a better `cat`

Prints files with **syntax highlighting**, line numbers, and Git change markers. It
auto-pages long files (like `less`).

```sh
bat file.py              # highlighted, with line numbers + git gutter
cat file.py              # alias -> bat --style=plain --paging=never (clean, no chrome)
catt file.py             # alias -> full bat (numbers, decorations)
bat -l json config       # force a language when the extension is missing
bat -A file              # show non-printable characters (tabs, spaces, CRLF)
```

Already wired in this setup:
- **`cat` / `catt`** aliases (in `linux_aliases.sh`).
- **`man` pages** are colorized through bat (`MANPAGER` in `.zshrc`).
- **fzf previews** use bat for file contents.

---

## fd — a better `find`

Simpler syntax, sensible defaults (respects `.gitignore`, skips hidden files unless
asked), parallel, and fast.

```sh
fd report                # find anything matching "report" under the current dir
fd -e md                 # all .md files
fd -H secret             # include hidden files
fd -t d node_modules     # directories only
fd -t f -e log -x rm     # find .log files and delete each (-x runs a command per result)
fd pattern /etc          # search a specific path
```

- Aliased to **`find`** (falls back to `fdfind` if installed via apt).
- Powers **fzf** file/dir search (`FZF_DEFAULT_COMMAND` in `.zshrc`).

---

## delta — a better `git diff`

Syntax-highlighted, side-by-side-capable diffs with line numbers and intra-line
change detection. Configured as Git's pager, so it works automatically.

```sh
git diff                 # now rendered by delta
git show HEAD
git log -p
git blame file           # delta improves this too
```

Inside a delta diff:
- `n` / `N` — jump to next/previous file or hunk (navigate mode is on).
- Use `git -c delta.side-by-side=true diff` for a one-off side-by-side view.

Configured in [`home/.gitconfig`](home/.gitconfig): `core.pager`, `interactive.diffFilter`,
`delta.navigate`, `delta.line-numbers`, plus `merge.conflictstyle = zdiff3` for clearer
conflict markers.

---

## dust — a better `du`

Shows what's eating your disk as a sorted, visual tree — no flag-juggling.

```sh
dust                     # tree of current dir, biggest first
du                       # alias -> dust
dust -d 2                # limit depth to 2 levels
dust -r                  # reverse (smallest first)
dust ~/Downloads         # inspect a specific directory
```

---

## procs — a better `ps`

Colored, human-readable process list with extra columns (TTY, CPU/mem, started, docker).

```sh
procs                    # all processes, colored table
ps                       # alias -> procs
procs firefox            # filter by name
procs --tree             # process tree
procs --sortd cpu        # sort by CPU descending (use 'mem' for memory)
procs --watch            # live-updating view
```

---

## sd — a better `sed` (for find & replace)

Intuitive search-and-replace using normal regex (no `s/.../.../g` ceremony).

```sh
sd 'foo' 'bar' file.txt          # replace in-place
echo "hello" | sd 'l+' 'L'       # works in pipes -> heLo
sd -p 'foo' 'bar' file.txt       # preview (dry-run) the changes
fd -e js -x sd 'var ' 'let '     # replace across many files via fd
```

- Aliased to **`subst`** (we intentionally do **not** override `sed`, since their
  syntax differs and scripts rely on real `sed`).

---

## navi — interactive cheatsheets

A searchable, fill-in-the-blanks cheatsheet of commands. Press **`Ctrl-G`** to open it
anywhere on the command line; pick a command and it fills the arguments for you.

```sh
navi                     # browse / search cheatsheets
# Ctrl-G                 # widget: insert a command into your current prompt
navi repo browse         # add community cheatsheets
```

The Ctrl-G widget is enabled in [`home/.zshrc`](home/.zshrc).

---

## yazi — terminal file manager

Fast, vim-like file manager with image previews. The **`y`** function launches it and
**cd's your shell** to wherever you quit.

```sh
y                        # open yazi; quit with q and your shell follows the cwd
```

Inside yazi (vim-style): `h/j/k/l` to navigate, `Enter` open, `Space` select,
`y`/`x`/`p` copy/cut/paste, `d` delete, `/` search, `q` quit. Press `~` for help.

The `y` wrapper is defined in [`shell/linux_aliases.sh`](shell/linux_aliases.sh).

---

## lazydocker — Docker TUI

A full dashboard for containers, images, volumes, and logs — no memorizing `docker`
flags.

```sh
lazydocker               # launch the dashboard
lzd                      # alias
```

Inside: arrow/`j`/`k` to move between panes and items, `Enter` to inspect, `d` to
remove, `r` to restart, `[`/`]` to switch tabs, `x` for the menu, `q` to quit.

---

## gh-dash — GitHub PR/issue TUI

A configurable dashboard for your pull requests and issues across repos, right in the
terminal. (Requires `gh auth login` first.)

```sh
gh dash                  # launch the dashboard
ghd                      # alias
```

Inside: `j`/`k` move, `Tab` switch sections (PRs/Issues), `Enter` open details,
`o` open in browser, `/` filter, `?` help, `q` quit. Customize the dashboards in
`~/.config/gh-dash/config.yml`.

---

## Tools already in this setup (for context)

These were installed previously and complement the above:

| Tool       | Purpose                                            |
|------------|----------------------------------------------------|
| `eza`      | Modern `ls` (icons, tree, git) — see `ll`/`la`/`lt`|
| `rg`       | ripgrep — fast recursive text search (`grep`)      |
| `fzf`      | Fuzzy finder (Ctrl-T files, Ctrl-R history, Alt-C cd)|
| `zoxide`   | Smarter `cd` that learns your habits               |
| `atuin`    | SQLite-backed, searchable shell history            |
| `btop`     | Resource monitor (`top`)                           |
| `duf`      | Disk free overview (`df`)                          |
| `lazygit`  | Git TUI                                             |
| `starship` / `powerlevel10k` | Prompts (toggle with `toggle`)   |
| `tldr`     | Community-driven simplified man pages              |

---

## fzf keybindings (enhanced here)

With `fd` + `bat` wired into fzf (see `.zshrc`):

- **`Ctrl-T`** — fuzzy-insert a file path (with a bat preview).
- **`Ctrl-R`** — fuzzy-search command history (via atuin).
- **`Alt-C`** — fuzzy `cd` into a subdirectory.
