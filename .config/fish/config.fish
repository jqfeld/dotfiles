if status is-interactive
  # Commands to run in interactive sessions can go here
  zoxide init fish | source
  starship init fish | source

  alias v nvim

  alias rs "source ~/.config/fish/config.fish"

  alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  alias v "nvim"
  alias j "julia"
  alias ls "exa -l"
  alias todo "v ~/Todos/todo.txt ~/Todos/done.txt"
  alias notes "zellij --layout notes --session notes"

  set -x TODO_FILE "/home/jk/Todos/todo.txt"
  set -x DONE_FILE "/home/jk/Todos/done.txt"
end
