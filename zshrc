# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# pipenv
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SHELL=zsh

# Path to your oh-my-zsh installation.
export ZSH="/Users/lucas/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable compinit
#ZSH_DISABLE_COMPFIX="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git tmux vscode vagrant node npm poetry docker docker-compose brew aws terraform helm ansible )

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# User configuration

### Autocompletions
source <(kubectl completion zsh)
source <(velero completion zsh)
complete -F __start_velero v
complete -F __start_kubectl k
complete -o nospace -C /usr/local/bin/terraform terraform
complete -o nospace -C /usr/local/bin/mc mc
# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/lucas/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

autoload -U +X bashcompinit && bashcompinit

### Example aliases
alias ll="ls -l"
alias k="kubectl"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Color
if [ -x "$(command -v exa)" ]; then
    alias ls="exa"
    alias la="exa --long --all --group"
fi

### Autocompletions
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
