# ============================================================================
# PROMPT THEME SELECTOR (Starship / Powerlevel10k)
# ============================================================================
# Toggle between themes using: toggle
# Check current theme: check-prompt
# Set specific theme: toggle starship OR toggle p10k

PROMPT_STATE_FILE="$HOME/.config/prompt_theme"

# Initialize state file if it doesn't exist (default to p10k)
if [[ ! -f "$PROMPT_STATE_FILE" ]]; then
    mkdir -p "$HOME/.config"
    echo "p10k" > "$PROMPT_STATE_FILE"
fi

CURRENT_PROMPT=$(cat "$PROMPT_STATE_FILE" 2>/dev/null || echo "p10k")

# ============================================================================
# POWERLEVEL10K CONFIGURATION (Only loaded if p10k is active)
# ============================================================================
if [[ "$CURRENT_PROMPT" == "p10k" ]]; then
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Enable P10k instant prompt
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Skip global compinit, we'll do it once at the end
skip_global_compinit=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set theme based on current selection
if [[ "$CURRENT_PROMPT" == "starship" ]]; then
    ZSH_THEME=""  # Disable Oh-My-Zsh theme when using Starship
else
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Speed up repo status in large repos (skip untracked-file scan)
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins — keep this list short; each one adds startup cost.
plugins=(
git
zsh-autosuggestions
z
zsh-syntax-highlighting
colored-man-pages
sudo
)

# Limit syntax highlighting to the fast highlighters (must be set BEFORE the
# plugin loads via oh-my-zsh.sh, otherwise it has no effect). Fewer highlighters
# = less work per keystroke on long command lines.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Tune autosuggestions for speed: cap the buffer it tries to suggest on and use
# async fetching so it never blocks typing.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

source $ZSH/oh-my-zsh.sh

# Load custom aliases
[ -f ~/.aliases ] && source ~/.aliases

# User configuration

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Configure autosuggestions appearance
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Better history behavior
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS    # Don't record duplicate entries
setopt HIST_IGNORE_SPACE       # Don't record entries starting with space
setopt HIST_VERIFY             # Show command before executing from history
setopt SHARE_HISTORY           # Share history across all sessions
setopt INC_APPEND_HISTORY      # Add commands immediately, not on exit
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands
setopt HIST_FIND_NO_DUPS       # Don't show duplicates when searching

# Make directory navigation smoother
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Kiro terminal integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Enable command completion with caching (only do the slow security check once
# per day; otherwise load the cached dump with -C). $ZDOTDIR was unset before, so
# the old glob looked at /.zcompdump and never matched -> full compinit every time.
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n ${_zcompdump}(#qN.mh+24) ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
# Compile the dump to bytecode in the background for a faster next startup
if [[ -s "$_zcompdump" && (! -s "${_zcompdump}.zwc" || "$_zcompdump" -nt "${_zcompdump}.zwc") ]]; then
  zcompile "$_zcompdump" &!
fi
unset _zcompdump

# Lazy load fzf - defer loading until first use
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# Homebrew env set statically instead of `eval "$(brew shellenv)"`, which forks a
# ruby/bash subprocess on every shell start (~50-100ms). PATH is already set in
# .zshenv; here we just export the prefixes brew tools expect.
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_ENV_HINTS=1
    [[ ":$MANPATH:" != *":/home/linuxbrew/.linuxbrew/share/man:"* ]] && export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH:+:$MANPATH}"
    [[ ":$INFOPATH:" != *":/home/linuxbrew/.linuxbrew/share/info:"* ]] && export INFOPATH="/home/linuxbrew/.linuxbrew/share/info${INFOPATH:+:$INFOPATH}"
fi

# ============================================================================
# STARSHIP PROMPT INITIALIZATION (Only loaded if starship is active)
# ============================================================================
if [[ "$CURRENT_PROMPT" == "starship" ]]; then
    export STARSHIP_CONFIG="$HOME/.config/starship.toml"
    if command -v starship &> /dev/null; then
        eval "$(starship init zsh)"
    else
        echo "Starship is not installed. Install it with:"
        echo "    curl -sS https://starship.rs/install.sh | sh"
        echo "    OR: brew install starship"
    fi
fi

# ============================================================================
# PROMPT SWITCHER FUNCTIONS
# ============================================================================
# Load prompt switcher functions
if [[ -f "$HOME/dot_files/shell/prompt_switcher.sh" ]]; then
    source "$HOME/dot_files/shell/prompt_switcher.sh"
elif [[ -f "$HOME/.dotfiles/shell/prompt_switcher.sh" ]]; then
    source "$HOME/.dotfiles/shell/prompt_switcher.sh"
fi

# GPG_TTY is exported once in .zshenv (avoids a second $(tty) subprocess here)

# Defer atuin initialization for faster startup
if [[ -f "$HOME/.atuin/bin/env" ]]; then
    . "$HOME/.atuin/bin/env"
    eval "$(atuin init zsh --disable-up-arrow)"
fi

# opencode PATH is already set in .zshenv (typeset -U keeps it unique)

# navi: interactive cheatsheet widget bound to Ctrl-G
if command -v navi >/dev/null 2>&1; then
    eval "$(navi widget zsh)"
fi

# bat as the colorizing pager for man pages
if command -v bat >/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# fzf: use fd for file/dir search (faster, respects .gitignore) + bat previews
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview-window=right:60%"
command -v bat >/dev/null 2>&1 && export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {}'"
