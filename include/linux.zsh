# Adicionando Flatpak ao PATH
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin

# Adicionando Flatpak aos XDG_DATA_DIRS
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share

# Adicionando node ao PATH
export PATH="/home/linuxbrew/.linuxbrew/opt/node@20/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@20/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@20/include"

# Alias
#Vim and Nvim
alias vi="nvim"
alias vim="nvim"
