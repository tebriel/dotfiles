fundle plugin 'tuvistavie/fish-ssh-agent'

fundle init

function load_config -d "Load in config files"
    . ~/.config/fish/dockers.fish
    # Load computer specific things
    switch (hostname)
    case Pipin.attlocal.net
        . ~/.config/fish/personal.fish
    end
end

function ruby_env -d "Set up ruby env"
    set PATH "$HOME/.gem/ruby/2.3.0/bin" $PATH
end

function shell_env -d "Set up general shell env"
    set -gx EDITOR vim
end

function brew_env -d "Set up brew PATH"
    set PATH '/usr/local/bin' '/usr/local/sbin' $PATH
end

function rust_env -d "Set up brew PATH"
    set PATH "$HOME/.cargo/bin" $PATH
end

function python_env -d "Set up python PATH"
    set PATH "$HOME/.local/bin" $PATH
end

function blackbox_env -d "Set up blackbox PATH"
    set -gx GPG (which gpg)
    set PATH "$HOME/work/src/github.com/StackExchange/blackbox/bin" $PATH
end

function docker_env -d "Set the docker env"
end

function virtualfish_env -d "Set up virtualfish"
    set -gx PROJECT_HOME ~/work/src/github.atl.pdrop.net/IVR/ivr-auth/
    eval (/usr/bin/python -m virtualfish auto_activation global_requirements compat_aliases projects)
end

function go_env -d "Set go environment variables"
    # Set up go environment
    set -gx GOPATH $HOME/work
    set PATH ~/bin $GOPATH/bin /usr/local/go/bin $PATH
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

function keychain_stuff -d "Sets up keychain stuff"
    if status --is-interactive
        set -l IFS
        eval (keychain --eval --quiet -Q id_rsa)
    end
end

function mall -d "Run the normal 'all' set of things"
    ~/bin/chowndir.sh
    make rm_containers build test service_test
end

function main_config -d "Set up all fish config"
    # load_config
    brew_env
    shell_env
    virtualfish_env
    go_env
    # ruby_env
    rust_env
    docker_env
    python_env
    extra_funcs
    github_token
    eval (hub alias -s fish)
    # blackbox_env
    # keychain_stuff
    # iterm3_env
    status --is-interactive; and source (rbenv init -|psub)
    # set PATH "$HOME/.nodenv/shims" $PATH
end

main_config

starship init fish | source

source (brew --prefix asdf)"/asdf.fish"

# Direnv plugin for asdf
eval (direnv hook fish)

set -gx SSH_AUTH_SOCK /Users/tebriel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
