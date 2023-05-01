# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Autoloads
autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disable compinit
#ZSH_DISABLE_COMPFIX="true"

### Config PATH

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# pipenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SHELL=zsh
# Mysql
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# Krew
export PATH="${PATH}:${HOME}/.krew/bin"
# c++
export PATH="/usr/local/opt/llvm/bin:$PATH"
# poetry
export PATH="$HOME/.poetry/bin:$PATH"
# Node.Js
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# Flutter
export PATH="$PATH:`pwd`/flutter/bin"
# Curl
export PATH="/usr/local/opt/curl/bin:$PATH"

### Config Theme

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Color
if [ -x "$(command -v exa)" ]; then
    alias ls="exa"
    alias la="exa --long --all --group"
fi

### Config Plugins
plugins=( git tmux vscode vagrant node npm poetry docker docker-compose brew aws terraform helm ansible zsh-syntax-highlighting )


#### User configuration

## Autocompletions
# Kubernetes
source <(kubectl completion zsh)
complete -F __start_kubectl k
# velero
source <(velero completion zsh)
complete -F __start_velero v
# terraform
complete -o nospace -C /usr/local/bin/terraform terraform
complete -o nospace -C /usr/local/bin/mc mc
# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/lucas/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

## Aliases
# ls
alias ll="ls -l"
# Kubernetes
alias k="kubectl"
# Velero
alias v="velero"
#Vim and Nvim
alias vi="vim"
alias vim="stty stop '' -ixoff; nvim"
# Tmux
alias tx="tmux"
alias txls="tmux ls"
# Git
alias gitc="git commit -a -m"
alias gita="git add ."
alias gitp="git push origin HEAD"
alias glabmrc="glab mr create -y -a username -t"
alias glabmra="glab mr approve"
alias glabmr="glab mr merge -y"
# Python
alias pa="source ./.venv/bin/activate"
alias pd="deactivate"
alias ipy="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias pipu="pip install --upgrade pip"
alias pipy="pip install ipython==8.1.1"
alias pipa="pipu && pipy"
alias venvc="virtualenv -p python3 .venv"
alias venva="venvc && pa && pipu && pipy && ipy && clear"
# Django
alias dj='python ./manage.py'
alias djrun="dj runserver"
# s5cmd
alias s5="s5cmd"
# Heroku
alias hk='heroku'
alias hkapps='heroku apps'

### Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
