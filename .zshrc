# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Environment variables
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PROJECT_PATHS="~/code/"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export PATH="$HOME/.cargo/bin:$PATH"
export N8N_RUNNERS_ENABLED=true
# N8N Variables
# export WEBHOOK_URL="https://b16f-2803-c180-2100-a7d1-142d-fe82-38eb-9ab7.ngrok-free.app"

# Aliases
alias v="nvim"
alias t="tmux attach -t 0 || tmux -u"
alias ia="sc"
alias fzfp='fzf --preview="bat --theme=gruvbox-dark --color=always {}"'
alias fzfv='nvim $(fzf --preview="bat --theme=gruvbox-dark --color=always {}")'
alias fzfcd='cd "$(fd --type d --hidden --exclude .git | fzf --preview="tree -C {} | head -100")"'
alias startMongo="brew services start mongodb-community@5.0"
alias stopMongo="brew services stop mongodb-community@5.0"
alias startSonar="/opt/sonarqube/bin/macosx-universal-64/sonar.sh start"
alias startScanner="$HOME/.dotnet/tools/dotnet-sonarscanner start"
alias ptop="bpytop"
alias matrix="cmatrix"

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
alias grh='git reset HEAD^ --hard'
alias grc='git rm -r --cached . && git add . && git commit -m "git cache cleared" && git push'
alias lg='lazygit'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

alias la=tree
alias cat=bat

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


# Functions
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

scroll-and-clear-screen() {
    printf '\n%.0s' {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

# Tool initializations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Language/tool version managers
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Load Angular CLI autocompletion
source <(ng completion script)

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/Users/felipemancillareyes/.lmstudio/bin"

. "$HOME/.local/bin/env"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/felipemancillareyes/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
