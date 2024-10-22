# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_CELLAR=$(brew --cellar)
export HOMEBREW_REPOSITORY=$(brew --repo)

# NVM 
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
export NVM_COMPLETION=true

# Mysql
export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"
# llvm
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
# Curl
export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
# Ruby
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
# OpenJDK
export PATH="$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH"

# Alias
#Vim and Nvim
alias vi="vim"
alias vim="stty stop '' -ixoff; nvim"
