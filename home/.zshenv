# .zshenv - Environment variables loaded before .zshrc
# This file is sourced for all shell types (login, interactive, scripts)

# Skip global compinit and zprofile for faster startup
skip_global_compinit=1

# Set PATH early to avoid duplicate lookups
typeset -U path  # Keep only unique entries in path

# Core paths
path=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    $HOME/.opencode/bin
    $HOME/go/bin
    $HOME/lua-language-server/bin
    $HOME/.local/share/pnpm
    $HOME/Android/Sdk/emulator
    $HOME/Android/Sdk/platform-tools
    $HOME/Android/Sdk/cmdline-tools/latest/bin
    $HOME/development/flutter/bin
    /opt/nodejs/bin
    /usr/local/go/bin
    /usr/local/bin
    /home/linuxbrew/.linuxbrew/bin
    $path
)

export PATH

# Load cargo environment (from original .zshenv)
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

# Editor settings
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"

# GPG TTY for password prompts
export GPG_TTY=$(tty)
