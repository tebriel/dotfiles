function load_config -d "Load in config files"
    . ~/.config/fish/dockers.fish
    # Load computer specific things
    switch (hostname)
    case atlmbp089.ad.pdrop.net
        . ~/.config/fish/pindrop.fish
    case ATLMBP089.local
        . ~/.config/fish/pindrop.fish
    case ATLMBP089.attlocal.net
        . ~/.config/fish/pindrop.fish
    case Pipin.attlocal.net
        . ~/.config/fish/personal.fish
    end
end

function shell_env -d "Set up general shell env"
    set -gx EDITOR vim
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

function extra_funcs -d "Extra configuration functions"
end

function iterm3_env -d "Install iTerm 3 Shell Integration"
    # iTerm 3 Shell Integration
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end

function github_token -d "Set github token"
    source ~/.github_token
end


function main_config -d "Set up all fish config"
    load_config
    brew_env
    shell_env
    virtualfish_env
    go_env
    docker_env
    extra_funcs
    github_token
    # iterm3_env
end

main_config
