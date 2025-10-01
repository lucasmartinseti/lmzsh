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
# codex
source <(codex completion zsh)
