if status is-interactive
  # Commands to run in interactive sessions can go here

  # Paths I use on every machine come here
  # Machine specific paths go into config.d/path.fish (gitignore)
  set PATH $PATH $HOME/.cargo/bin

  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  zoxide init fish | source
  starship init fish | source

  set -U fish_greeting

  alias v nvim

  alias rs "source ~/.config/fish/config.fish"

  alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  alias v "nvim"
  alias vj "nvim --listen /run/user/1000/nvim.julia.0"
  alias j "julia"
  alias jp "julia --project=@."
  alias ls "exa -l"
  alias todos "v ~/Todos/todo.txt ~/Todos/done.txt"
  alias nw "v -c ':Neorg workspace work'"
  alias np "v -c ':Neorg workspace personal'"
  alias x xplr
  function xz
    z (xplr --print-pwd-as-result)
  end
  function xv
    v (xplr --print-pwd-as-result)
  end


  set -x TODO_FILE "/home/jk/Todos/todo.txt"
  set -x DONE_FILE "/home/jk/Todos/done.txt"



end
