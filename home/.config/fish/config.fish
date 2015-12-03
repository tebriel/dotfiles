# ulimit -n 1024000
set -x PATH "$HOME/homebrew/bin" ~/bin "$HOME/homebrew/opt/go/libexec/bin" $PATH
set -x GOPATH "$HOME/work"
set -x EDITOR /Users/cmoultrie/homebrew/bin/mvim
source $HOME/Git/cmoultrie/virtualfish/virtual.fish
source $HOME/Git/cmoultrie/virtualfish/auto_activation.fish

# RBENV Stuffs
# set -gx RBENV_ROOT $HOME/homebrew/var/rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
# rbenv
# . (rbenv init -|psub)
# Re-Enable if you start using boot2docker again
# . (boot2docker shellinit -|psub)

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

function updatedb -d "Updates the fds-ui db to the latest"
    wget --auth-no-challenge --http-user=cmoultrie --http-password=4571f0cec0665f666ad4265020611053 --secure-protocol=TLSv1 http://jenkins.atl.pdrop.net:8080/view/Fraud/job/FDS-SS%20Database%20Dump/lastSuccessfulBuild/artifact/dbdump/fdsdata.sql -O ~/Downloads/fdsdata.sql
    mysql -uroot -e "Drop database fds; create database fds;"
    mysql -uroot fds < ~/Downloads/fdsdata.sql
end

function workremote -d "Set up the necessary remote tunnels"
    echo Setting up SOCKS Proxy
    sudo networksetup -setproxybypassdomains Wi-Fi 169.254/16 localhost 0.0.0.0 *.com *.org *.co *.in
    sudo networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 5000 off
    sudo networksetup -setsocksfirewallproxystate Wi-Fi on
    sudo gsed -i '/127.0.0.1       hipchat.pdrop.net/d' /etc/hosts
    sudo gsed -i '/127.0.0.1       elk1.atl.pdrop.net/d' /etc/hosts
    echo "127.0.0.1       hipchat.pdrop.net" | sudo tee -a /etc/hosts
    echo "127.0.0.1       elk1.atl.pdrop.net" | sudo tee -a /etc/hosts
    echo Tunneling to Work
    ssh -L 5222:hipchat.pdrop.net:5222 -L 5223:hipchat.pdrop.net:5223 -L 8080:elk1.atl.pdrop.net:8080 airavat -CND 0.0.0.0:5000
    echo Turning off SOCKS Proxy
    sudo networksetup -setsocksfirewallproxystate Wi-Fi off
    sudo gsed -i '/127.0.0.1       hipchat.pdrop.net/d' /etc/hosts
    sudo gsed -i '/127.0.0.1       elk1.atl.pdrop.net/d' /etc/hosts
end

function workemail -d "Run a mutt container"
    . ~/.gmailstuff
    docker run -it --rm -v /etc/localtime:/etc/localtime -v $HOME/tmp:/tmp -e GMAIL -e GMAIL_NAME -e GMAIL_PASS -e GMAIL_FROM cmoultrie/mutt
end

function dirssi -d "Run an IRSSI container"
    docker run -it --rm \
    -v /etc/localtime:/etc/localtime \
    -v $HOME/.irssi:/home/user/.irssi \
    --link bitlbee \
    --name irssi \
    jess/irssi
end

function dvim -d "Run vim in a docker"
    switch (count $argv)
    case 0
        set workdir (pwd)
    case 1
        set workdir $argv[1]
    end

    docker run -it --rm -v $workdir:/home/user/workdir -v ~/.ssh:/home/user/.ssh cmoultrie/vim
end
