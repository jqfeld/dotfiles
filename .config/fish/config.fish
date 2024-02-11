if status is-interactive
  # Commands to run in interactive sessions can go here

  # Paths I use on every machine come here
  # Machine specific paths go into config.d/path.fish (gitignore)
  set PATH $PATH $HOME/.cargo/bin

  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  zoxide init fish | source
  starship init fish | source

  set -U fish_greeting

  alias rs "source ~/.config/fish/config.fish"
  source ~/.config/fish/conf.d/*

  alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  alias v "nvim"
  alias vj "nvim --listen /run/user/1000/nvim.julia.0"
  alias vl "nvim --listen /run/user/1000/nvim.latex.0"
  alias vf "nvim ~/.config/fish/config.fish"
  alias j "julia -t auto"
  alias jp "julia -t auto --project=@."
  alias ls "exa -l"

  # Notes
  # alias nw "v -c ':Neorg workspace work'"
  # alias np "v -c ':Neorg workspace personal'"

  # File browsers
  alias jo "joshuto"


  function fish_greeting
    # sleep 0.01
    # echo (set_color -o red)Urgent tasks(set_color normal)
    # tada urgent
    # echo
    # echo (set_color -o yellow)Important tasks(set_color normal)
    # tada important
  end

end

set -x BAT_THEME "Catppuccin-mocha"

# Created by `pipx` on 2023-09-01 08:06:28
set PATH $PATH /home/jk/.local/bin
