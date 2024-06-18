
alias dotfiles = /usr/bin/git --git-dir=/home/jk/.dotfiles/ --work-tree=/home/jk/

alias j = julia 
alias jp = julia --project=@.

alias gitroot = git rev-parse --show-toplevel
alias projectname = basename (gitroot)
alias zp =  zellij a (projectname | cat)

# projects
alias pc = br ~/Projects/Current
alias pa = br ~/Projects/Archive


