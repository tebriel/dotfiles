function load_config -d "Load in config files"
    . ~/.config/fish/dockers.fish
    # Load computer specific things
    switch (hostname)
    case ATLMBP089.ad.pdrop.net
        . ~/.config/fish/pindrop.fish
    case Pipin.attlocal.net
        . ~/.config/fish/personal.fish
    end
end

function brew_env -d "Set up brew PATH"
    set PATH '/usr/local/bin' '/usr/local/sbin' $PATH
end

function docker_env -d "Set the docker env"
end

function virtualfish_env -d "Set up virtualfish"
    eval (python -m virtualfish auto_activation)
end

function go_env -d "Set go environment variables"
    # Set up go environment
    set -gx GOPATH $HOME/work
    set PATH ~/bin $GOPATH/bin $PATH
end

function main_config -d "Set up all fish config"
    load_config
    brew_env
    shell_env
    virtualfish_env
    go_env
    docker_env
end

main_config
