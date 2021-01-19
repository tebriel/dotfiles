[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . $(brew --prefix asdf)/asdf.sh

export PATH="$HOME/.asdf/bin:$PATH"

# Hook direnv into your shell.
eval "$(asdf exec direnv hook bash)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

#  Doesn't work for some reason
# autoload bashcompinit
# bashcompinit
# source $HOME/.config/alacritty/alacritty.bash

export EDITOR=vim

export PATH="/usr/local/sbin:$PATH"

# Allow secretive to do ssh/git auth
export SSH_AUTH_SOCK=/Users/tebriel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

eval "$(starship init zsh)"
eval "$(rbenv init -)"

# Init asdf
. $(brew --prefix asdf)/asdf.sh
eval "$(direnv hook zsh)"

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source $HOME/.local/bin/virtualenvwrapper.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH"
