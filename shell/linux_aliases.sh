# Directory Listing (modern eza)
alias ll="eza -la --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias l="eza --icons --group-directories-first"
alias lt="eza -l --sort=modified --icons --group-directories-first"
alias ltr="eza -l --sort=modified --reverse --icons --group-directories-first"
alias lsd="eza -D --icons --group-directories-first"

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
