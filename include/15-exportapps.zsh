# go bin exec
export PATH=$PATH:$(go env GOPATH)/bin
# pipenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SHELL=zsh
