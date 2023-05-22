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

fpath=( ~/.zshfn "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

### Config PATH

# Path scripts lmzsh
export PATH="$HOME/.config/lmzsh/bin:$PATH"
# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_CELLAR=$(brew --cellar)
export HOMEBREW_REPOSITORY=$(brew --repo)
# pipenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SHELL=zsh
# Mysql
export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"
# llvm
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
# Curl
export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
# Ruby
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"

### Config Plugins
plugins=( macos git tmux vscode vagrant node npm poetry docker docker-compose brew aws terraform helm ansible zsh-syntax-highlighting zsh-colorls zsh-nvm )

### Config Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
export NVM_COMPLETION=true

## Aliases
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

### Load
source $ZSH/oh-my-zsh.sh
