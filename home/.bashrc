alias ssr="ssh -l root"
alias jas="jasmine-node --color --coffee spec/"
alias gct="git add . && git commit"

export PS1='->\u@\h:\w \$ '
export PATH='/usr/local/bin:/Users/cmoultrie/Git/mutt-notmuch-py':$PATH
export TMPDIR=$HOME/tmp
export WORKON_HOME=~/Envs
export EDITOR='vim -f'

if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

set -o vi

