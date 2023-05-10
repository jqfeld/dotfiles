# dotfiles

## Install
### Dependencies
First install dependencies:

- Shell: `fish`
- WM: `awesomewm`
- Terminal emulator: `kitty`
- Editor: `neovim`
- Terminal multiplexer: `zellij`
- File explorer: `xplr`
- Misc: `zoxide`

### Clone repo
Add alias to .zshrc:
```fish
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
Add git folder to `.gitingore`:
```fish
echo ".dotfiles" >> .gitignore
```
Clone:
```fish
git clone --bare https://github.com/jqfeld/dotfiles $HOME/.dotfiles
```
Add alias to current shell (or maybe source .zshrc...):
```fish
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
Checkout:
```fish
config checkout
```
To ignore untracked files:
```fish
config config --local status.showUntrackedFiles no
```
