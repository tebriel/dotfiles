alias ssr="ssh -l root"
alias jas="jasmine-node --color --coffee spec/"
alias gct="git add . && git commit"
alias gco="git checkout"
alias gpo="git push origin"
alias j="jira -s \"assignee = cmoultrie and status in (Open, Reopened, 'In Progress')\""
alias moultrie="mutt -F ~/.moultrie-muttrc"
#export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export PATH=$HOME'/bin:'$HOME'/.cabal/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin'
export TMPDIR=$HOME/tmp
export WORKON_HOME=~/Envs
export EDITOR='vim -f'

if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

source $HOME/.profile


#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi

set -o vi

ulimit -n 1200

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
