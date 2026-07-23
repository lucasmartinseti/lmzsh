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
# wrangler
source <(wrangler complete zsh)
source <(lux completion zsh)
# lux (registra os dois nomes: o atalho `lux` e o binário `lx`)
#command -v lux       >/dev/null 2>&1 && source <(lux completion zsh)
#command -v lx >/dev/null 2>&1 && source <(lx completion zsh)

# agents-cli (registra os dois nomes: o atalho `acli` e o binário `agents-cli`)
command -v acli       >/dev/null 2>&1 && source <(acli completion zsh)
command -v agents-cli >/dev/null 2>&1 && source <(agents-cli completion zsh)
