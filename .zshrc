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
TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ======================
# Aliases
# ======================
alias startMongo="brew services start mongodb-community@5.0"
alias stopMongo="brew services stop mongodb-community@5.0"
alias v="nvim"
alias startSonar="/opt/sonarqube/bin/macosx-universal-64/sonar.sh start"
alias startScanner="/Users/felipemancillareyes/.dotnet/tools/dotnet-sonarscanner start"
alias ia="sc"
alias t="tmux attach -t 0 || tmux -u"

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
