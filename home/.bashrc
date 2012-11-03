alias ssr="ssh -l root"
export PS1="->\u@\h:\w \$ "
export PATH="/Users/tebriel/Documents/GitHub/mutt-notmuch-py":$PATH:"/usr/local/bin"
export TMPDIR=$HOME/tmp
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
