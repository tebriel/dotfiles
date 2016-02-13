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
    set -x PATH "$HOME/homebrew/bin" $PATH
end

rbenv_env
