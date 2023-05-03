### Install and config Zsh

#### Install dependencies

###### macOS

```console
brew install zsh zsh-completions ruby rbenv
gem install colorls
```

##### Install Oh My Zsh

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Configure Zsh

```console
git clone git@gitlab.com:lucasmartins.py/lmzsh.git ~/.config/lmzsh
rm -rf ~/.zshrc
ln -s -f ~/.config/lmzsh/zshrc ~/.zshrc
ln -s -f ~/.config/lmzsh/zsh-colorls ~/.oh-my-zsh/custom/plugins/zsh-colorls
```

##### Configure zsh-syntax-highlighting

```console
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

##### Configure PowerLevel10k theme

```console
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
    Close and open terminal to se changes.
