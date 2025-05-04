## Aliases
# Kubernetes
alias k="kubectl"
# Velero
alias v="velero"
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
# gpg
alias gpgchat='gpg --decrypt ~/.config/openai/secret.txt.gpg'
# AI
alias ai='aichat'
