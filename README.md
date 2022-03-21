# dotfiles

WIP

## Install
### Dependencies
First install dependencies.

oh-my-zsh and plugins:
```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Clone repo
Add alias to .zshrc:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
Add git folder to `.gitingore`:
```sh
echo ".dotfiles" >> .gitignore
```
Clone:
```sh
git clone --bare https://github.com/jqfeld/dotfiles $HOME/.dotfiles
```
Add alias to current shell (or maybe source .zshrc...):
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
Checkout:
```sh
config checkout
```
