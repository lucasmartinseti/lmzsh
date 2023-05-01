### Install and config Zsh

#### Install dependencies

###### macOS

```console
brew install zsh zsh-completions zsh-syntax-highlighting powerlevel10k exa
```

##### Install Oh My Zsh

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Configure Zsh

```console
git clone git@gitlab.com:lucasmartins.py/lmzsh.git ~/.config/lmzsh
```

##### Configure Zsh

```console
rm -rf ~/.zshrc
ln -s ~/.config/lmzsh/zshrc ~/.zshrc
```

##### Configure PowerLevel10k theme

```console
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
    Close and open terminal to see changes.
