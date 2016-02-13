function brew_env -d "Set up brew PATH"
    set PATH '/usr/local/bin' '/usr/local/sbin' $PATH
end

function virtualfish_env -d "Set up virtualfish"
    eval (python -m virtualfish auto_activation)
end

function go_env -d "Set go environment variables"
    # Set up go environment
    set -x GOPATH $HOME/work
    set PATH ~/bin $GOPATH/bin $PATH
end

brew_env
virtualfish_env
go_env

# Load in other config files
. ~/.config/fish/dockers.fish
