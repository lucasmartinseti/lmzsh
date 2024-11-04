### Install and config Zsh

#### Install dependencies

###### macOS

```console
brew install zsh zsh-completions ruby rbenv git
gem install colorls
```

###### Linux (Debian e Ubuntu)

```console
sudo apt install -y zsh ruby ruby-dev git curl build-essential libssl-dev zlib1g-dev libreadline-dev fontconfig
sudo gem install colorls
```

```console
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
cd ~/.local/share/fonts
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
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
git clone https://github.com/lukechilds/zsh-nvm.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
```

##### Configure Zsh

```console
git clone https://gitlab.com/lucasmartinseti/lmzsh.git ~/.config/lmzsh
ln -s -f ~/.config/lmzsh/zshrc ~/.zshrc
ln -s -f ~/.config/lmzsh/zsh-colorls ~/.oh-my-zsh/custom/plugins/zsh-colorls
ln -s -f ~/.config/lmzsh/bin ~/.zshfn
ln -s -f ~/.config/lmzsh/config_ssh.d/config ~/.ssh/config
```

##### Create ssh key and config

###### Generate ssh key

```console
ssh-keygen -t rsa -b 4096 -C "email@example.com" -f ~/.ssh/id_rsa_exemplo
ssh-add ~/.ssh/id_rsa_exemplo
```

###### Configure ssh-agent

Include an file ~/.config/lmzsh/config_ssh.d/config with:

```console
Host glexemplo
  HostName gitlab.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa_exemplo
```
