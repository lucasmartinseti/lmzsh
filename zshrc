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

#fpath=( ~/.zshfn "${fpath[@]}" )
#autoload -Uz $fpath[1]/*(.:t)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

### Config PATH
# Path lmzsh
export PATH_LMZSH="$HOME/.config/lmzsh"

# Path scripts lmzsh
export PATH="$PATH_LMZSH/bin:$PATH"

# Check OS in .zshrc
# Config Linux
if [[ "$(uname -s)" == "Linux" ]]; then
    
    # Includes
    for includes in $PATH_LMZSH/include/*.zsh; do
      if [[ -f $includes && "$includes" != "$PATH_LMZSH/include/10-macOS.zsh" ]]; then
        source $includes
      fi
    done
    
    ### Load
    source $ZSH/oh-my-zsh.sh

# Config macOS
elif [[ "$(uname -s)" == "Darwin" ]]; then

    # Includes
    for includes in $PATH_LMZSH/include/*.zsh; do
      if [[ -f $includes && "$includes" != "$PATH_LMZSH/include/10-linux.zsh" ]]; then
        source $includes
      fi
    done

    ### Load
    source $ZSH/oh-my-zsh.sh

else
    printf "Sistema Operacional não suportado.\n"
fi
