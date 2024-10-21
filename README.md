### Install and config Zsh

#### Install dependencies

###### macOS

```console
brew install zsh zsh-completions ruby rbenv git
gem install colorls
```

###### Linux (Debian e Ubuntu)

```console
sudo apt install zsh ruby rubenv ruby-dev git
```

###### Install all SO

##### Install Oh My Zsh

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Configure PowerLevel10k theme

```console
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
    Close and open terminal to se changes.

##### Configure zsh-syntax-highlighting

```console
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

##### Configure Zsh
```console
git clone https://github.com/lucasmartinseti/lmzsh.git ~/.config/lmzsh
ln -s -f ~/.config/lmzsh/zshrc ~/.zshrc
ln -s -f ~/.config/lmzsh/zsh-colorls ~/.oh-my-zsh/custom/plugins/zsh-colorls
ln -s -f ~/.config/lmzsh/bin ~/.zshfn
```
