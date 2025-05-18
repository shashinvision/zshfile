# ======================
# Powerlevel10k Instant Prompt
# ======================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ======================
# Path Configuration
# ======================
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/home/felipe/.local/bin"         # pipx
export PATH="$PATH:/home/felipe/.cargo/bin"         # Rust
export PATH="/opt/anaconda3/bin:$PATH"              # Anaconda
export PATH="$PYENV_ROOT/bin:$PATH"                 # pyenv
export PATH="$HOME/.dotnet:$PATH"                   # .NET Core

# ======================
# Oh-My-Zsh Configuration
# ======================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# ======================
# Terminal Configuration
# ======================
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PROJECT_PATHS="~/code/"
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"

# ======================
# Aliases
# ======================
alias v="nvim"
alias ia="sc"
alias t="tmux attach -t 0 || tmux -u"
alias fd='fd=fdfind'
alias fzfp='fzf --preview="batcat --theme=gruvbox-dark --color=always {}"'
alias fzfv='nvim $(fzf --preview="batcat --theme=gruvbox-dark --color=always {}")'
alias fzfcd='cd "$(fdfind --type d --hidden --exclude .git | fzf --preview="tree -C {} | head -100")"'

# navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }


# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias gl="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gld="git log --stat --decorate --graph --date=relative"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

alias la=tree
alias cat=batcat

alias cl='clear'

# K8S
export KUBECONFIG=~/.kube/config
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

# ======================
# Functions
# ======================
# Tmux session attachment/create function
tat() {
  name=$(basename `pwd` | sed -e 's/\.//g')
  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Clear screen with scroll preservation
scroll-and-clear-screen() {
    printf '\n%.0s' {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

# ======================
# Environment Variables
# ======================
export DOTNET_ROOT=$HOME/.dotnet
export DOTNET_ROLL_FORWARD=Major
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"

# ======================
# Tool Initializations
# ======================
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Angular CLI autocompletion
source <(ng completion script)

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# conda
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    fi
fi
unset __conda_setup

# ======================
# Powerlevel10k Finalization
# ======================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
