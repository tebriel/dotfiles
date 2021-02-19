# Add profiling
# run `time zsh -i -c exit` to determine how long it took, also uncommment the zprof line at the end
# zmodload zsh/zprof
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.asdf/bin:$PATH"

# Init asdf, this should come before compinit
. $(brew --prefix asdf)/asdf.sh
# Hook direnv into your shell.
eval "$(asdf exec direnv hook zsh)"

# Homebrew Tab Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$HOME/.config/alacritty/completions:$FPATH

  autoload -Uz compinit
  compinit
fi

export EDITOR=vim

# ??? Pathing
# export PATH="/usr/local/sbin:$PATH"
# Node Pathing
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Python Pathing
export PATH="$HOME/.local/bin:$PATH"

# Allow secretive to do ssh/git auth
export SSH_AUTH_SOCK=/Users/tebriel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
eval "$(rbenv init -)" # 200ms
eval "$(zoxide init zsh)"
# zprof
