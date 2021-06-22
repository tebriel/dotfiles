# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Configure Nix
if [ -e /Users/tebriel/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tebriel/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
# 
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


## FZF Config ##
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# # command for listing path candidates.
# # - The first argument to the function ($1) is the base path to start traversal
# # - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
   fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
## End FZF Config ##

# Starship Config
# export STARSHIP_CONFIG=~/.config/starship.toml
# eval "$(starship init zsh)"

source ~/work/src/github.com/romkatv/powerlevel10k/powerlevel10k.zsh-theme

eval "$(rbenv init -)" # 200ms
eval "$(zoxide init zsh)"
# zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load custom functions
fpath+=$HOME/.config/zsh/functions

# Must specifically call them out
autoload thehub
