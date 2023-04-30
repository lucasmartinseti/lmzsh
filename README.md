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

z
##### Install node packages

```console
npm i -g pyright
```

##### Install plugins on nvim

```console
nvim -c 'PlugInstall' -c 'qa'
nvim -c 'UpdateRemotePlugins' -c 'qa'
```

##### Enable Wakatime plugin

```console
nvim -c 'WakaTimeApiKey'
```
> Access Wakatime API key at https://wakatime.com/settings/account

##### Enable Codeium plugin

```console
nvim -c 'Codeium Auth'
```
