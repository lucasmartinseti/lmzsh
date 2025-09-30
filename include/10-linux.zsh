# Adicionando Flatpak ao PATH
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin

# Adicionando Flatpak aos XDG_DATA_DIRS
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share

# Adicionando homebrew ao PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_CELLAR=$(brew --cellar)
export HOMEBREW_REPOSITORY=$(brew --repo)

# Adicionando node ao PATH
export PATH="$HOMEBREW_PREFIX/opt/node@20/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/node@20/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/node@20/include"

# Adicionando zsh-completions ao PATH
export PATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$PATH"

# Adicionando mysql ao PATH
export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"

# nvm completions
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"

# Add local bin to PATH
export PATH=$HOME/.local/bin:$PATH >> ~/.zshrc

# Alias
#Vim and Nvim
alias vi="nvim"
alias vim="nvim"
