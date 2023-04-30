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
cp -a zshrc ~/.zshrc
```

##### Configure PowerLevel10k theme

```console
echo "ZSH_THEME="powerlevel10k/powerlevel10k"" >> ~/.zshrc
```

```console
p10k configure
```
