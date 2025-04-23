alias t="tmux attach -t 0 || tmux -u"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# function tat {
#   name=$(basename `pwd` | sed -e 's/\.//g')
#    if tmux ls 2>&1 | grep "$name"; then
#      tmux attach -t "$name"
#    elif [ -f .envrc ]; then
#      direnv exec / tmux new-session -s "$name"
#    else
#      tmux new-session -s "$name"
#    fi
#  }
# Custum
TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# tat: tmux attach

# function tat {
#   name=$(basename "$(pwd)" | sed -e 's/\.//g')
#
#   if tmux ls 2>&1 | grep "$name"; then
#     tmux attach -t "$name"
#   elif [ -f .envrc ]; then
#     direnv exec / tmux new-session -s "$name"
#   else
#     tmux new-session -s "$name"
#   fi
# }



# Tmux autostart
# [ -z "$TMUX" ] && (tmux attach -t 0 || tmux new -s 0)



scroll-and-clear-screen() {
    printf '\n%.0s' {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
