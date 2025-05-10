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

# Aliases
alias v="nvim"
alias t="tmux attach -t 0 || tmux -u"
alias ia="sc"
alias fzfp='fzf --preview="bat --theme=gruvbox-dark --color=always {}"'
alias fzfv='nvim $(fzf --preview="bat --theme=gruvbox-dark --color=always {}")'
alias fzfcd='cd "$(fdfind --type d --hidden --exclude .git | fzf --preview="tree -C {} | head -100")"'
alias startMongo="brew services start mongodb-community@5.0"
alias stopMongo="brew services stop mongodb-community@5.0"
alias startSonar="/opt/sonarqube/bin/macosx-universal-64/sonar.sh start"
alias startScanner="$HOME/.dotnet/tools/dotnet-sonarscanner start"

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
