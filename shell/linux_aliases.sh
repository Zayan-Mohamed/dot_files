[[ -o interactive ]] || return

# Directory Listing (modern eza)
alias ll="eza -la --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias l="eza --icons --group-directories-first"
alias lt="eza -l --sort=modified --icons --group-directories-first"
alias ltr="eza -l --sort=modified --reverse --icons --group-directories-first"
alias lsd="eza -D --icons --group-directories-first"

# Modern CLI Tools
alias cat="batcat"
alias bat="batcat"

# General Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cls="clear"
alias e="exit"
alias c="clear"
alias h="history"
alias j="jobs"
alias please="sudo"

# System Info
alias cpuinfo="lscpu"
alias meminfo="free -h"
alias df="df -h"
alias du="du -h"
alias top="htop"
alias psu="ps aux --sort=-%cpu | head"
alias psm="ps aux --sort=-%mem | head"

# Cleanup
alias cleanup="sudo apt autoremove && sudo apt clean"
alias rm="rm -i"
alias rmr="rm -rf"
alias clrlog="sudo journalctl --vacuum-time=3d"

# APT Package Management
alias update="sudo apt update && sudo apt upgrade -y"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias search="apt search"

# Networking
alias ipinfo="ip a"
alias ports="netstat -tulanp"
alias pingg="ping google.com"
alias myip="curl ifconfig.me"
alias flushdns="sudo systemd-resolve --flush-caches"

# Permissions
alias chmodx="chmod +x"
alias chownme="sudo chown $USER:$USER"

# File Operations
alias mkd="mkdir -p"
alias cpv="rsync -ah --info=progress2"
alias untar="tar -xvzf"
alias extract="a() { tar -xf \"$1\"; }; a"

# Docker Aliases
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dstart="docker start"
alias dstop="docker stop"
alias drm="docker rm"
alias drmi="docker rmi"
alias dexec="docker exec -it"

# Git Aliases
alias gs="git status"
alias gl='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gcs="git commit -s -m"
alias gca="git commit -a -m"
alias gp="git push"
alias gpl="git pull"
alias gb="git branch"
alias gco="git checkout"
alias gpsu='git push --set-upstream origin'
alias gd='git branch -d'
alias gdf='git branch -D'
alias gdr='git push origin --delete'

# Miscellaneous
alias reload="source ~/.zshrc"
alias serve="python3 -m http.server"
alias timestamp="date +%Y-%m-%d_%H-%M-%S"

# Conda Environment Management
alias ca="conda activate"
alias cda="conda deactivate"
alias ce="conda env list"
alias cn="conda create -n"
alias crm="conda remove --name"
alias crma="conda remove --name --all"

# Conda Environment Export/Import
alias cexp="conda env export > environment.yml"
alias cimp="conda env create -f environment.yml"

# Conda Package Management
alias ci="conda install"
alias cu="conda update"
alias cup="conda update --all"
alias cr="conda remove"
alias cl="conda list"

# Conda Info & Cleanup
alias cinfo="conda info"
alias cclean="conda clean --all -y"

# Conda Search
alias cs="conda search"
alias csf="conda search --full-name"

# ============================================================================
# Modern CLI Tool Replacements (with fallbacks)
# ============================================================================

# Better cat with syntax highlighting (bat)
if command -v bat >/dev/null 2>&1; then
  alias cat="bat --style=plain --paging=never"
  alias catt="bat"  # Full bat with line numbers
fi

# Better find (fd)
if command -v fdfind >/dev/null 2>&1; then
  alias find="fdfind"
fi

# Better grep (ripgrep)
if command -v rg >/dev/null 2>&1; then
  alias grep="rg"
fi

# Better ps (procs)
if command -v procs >/dev/null 2>&1; then
  alias ps="procs"
fi

# Better du (dust)
if command -v dust >/dev/null 2>&1; then
  alias du="dust"
fi

# Better df (duf)
if command -v duf >/dev/null 2>&1; then
  alias df="duf"
fi

# ============================================================================
# Safety Aliases (prevent accidents)
# ============================================================================

alias cp="cp -i"          # Interactive copy (confirm overwrite)
alias mv="mv -i"          # Interactive move (confirm overwrite)
alias ln="ln -i"          # Interactive link (confirm overwrite)

# Better defaults
alias mkdir="mkdir -p"    # Create parent directories automatically
alias wget="wget -c"      # Continue downloads by default

# ============================================================================
# Quick Project Navigation
# ============================================================================

alias cdp="cd ~/projects"
alias cdd="cd ~/dot_files"
alias cddl="cd ~/Downloads"
alias cddc="cd ~/Documents"

# ============================================================================
# Quick Edits
# ============================================================================

alias vimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc && source ~/.zshrc"
alias aliases="nvim ~/.aliases && source ~/.aliases"
alias gitconfig="nvim ~/.gitconfig"

# ============================================================================
# Enhanced Git Workflow
# ============================================================================

alias gst="git status -sb"                              # Short status
alias glog="git log --oneline -10"                      # Last 10 commits
alias gwip="git add -A && git commit -m 'WIP'"          # Quick WIP commit
alias gunwip="git reset HEAD~1"                         # Undo WIP
alias gclean="git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d"

# ============================================================================
# Docker Compose Shortcuts
# ============================================================================

alias dc="docker-compose"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"
alias dcr="docker-compose restart"

# ============================================================================
# System Maintenance
# ============================================================================

alias sysupdate="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias sysfull="sysupdate && conda update --all -y && npm update -g"

# ============================================================================
# Development Workflow
# ============================================================================

# Python virtual environments
alias venv="python3 -m venv venv"
alias activate="source venv/bin/activate"

# Quick servers
alias serve="python3 -m http.server"
alias serve8080="python3 -m http.server 8080"

# Node/npm shortcuts
alias ni="npm install"
alias nid="npm install --save-dev"
alias nrs="npm run start"
alias nrb="npm run build"
alias nrt="npm run test"

# ============================================================================
# Utilities
# ============================================================================

alias timestamp="date +%Y-%m-%d_%H-%M-%S"
alias path='echo $PATH | tr ":" "\n"'
alias myip="curl -s ifconfig.me"
alias weather="curl wttr.in"
