function getlog -d "Get the latest log file"
    set yesterday (math (date "+%d")-1)
    set logfile pindrop.log.(date "+%Y.%m").$yesterday
    set archdir ~/git/vagrant-elk-box/prs/archive
    set logdir ~/git/vagrant-elk-box/prs/logs
    echo fetch $logfile from beaumonde
    rsync -paz beaumonde:/var/log/pindrop.log.1 $archdir/$logfile
    echo copying $logfile to $logdir
    cp $archdir/$logfile $logdir
    echo gzipping $logfile
    gzip $archdir/$logfile
end

# Override the regular one to link bitlbee
function dirssi -d "Run an IRSSI container"
    docker run -it --rm \
    -v /etc/localtime:/etc/localtime \
    -v $HOME/.irssi:/home/user/.irssi \
    --link bitlbee \
    --name irssi \
    jess/irssi
end

function rbenv_env -d "Set up rbenv variables"
    set PATH $HOME/.rbenv/bin $PATH
    set PATH $HOME/.rbenv/shims $PATH
    rbenv rehash >/dev/null ^&1
end

function brew_env -d "Set up Pindrop Brew ENV"
    set -gx PATH "$HOME/homebrew/bin" $PATH
    set -gx HOMEBREW_CASK_OPTS "--caskroom=$HOME/homebrew/Caskroom"
end

function docker_env -d "Set the docker environment up"
    eval (docker-machine env dev)
end

function go_env -d "Set go environment variables"
    # Set up go environment
    set -gx GOPATH $HOME/work
    set PATH ~/bin $GOPATH/bin $PATH
end

function getlog -d "Get the latest log file"
    set yesterday (math (date "+%d")-1)
    set logfile pindrop.log.(date "+%Y.%m").$yesterday
    set archdir ~/git/vagrant-elk-box/prs/archive
    set logdir ~/git/vagrant-elk-box/prs/logs
    echo fetch $logfile from beaumonde
    rsync -paz beaumonde:/var/log/pindrop.log.1 $archdir/$logfile
    echo copying $logfile to $logdir
    cp $archdir/$logfile $logdir
    echo gzipping $logfile
    gzip $archdir/$logfile
end

function workremote -d "Set up the necessary remote tunnels"
    sshuttle --dns -vr airavat 0/0 --dns
end

rbenv_env
