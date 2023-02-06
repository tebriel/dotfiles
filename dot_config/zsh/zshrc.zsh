# Configure Nix
if [ -e /Users/tebriel/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tebriel/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
