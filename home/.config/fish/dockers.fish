function dirssi -d "Run an IRSSI container"
    docker run -it --rm \
    -v /etc/localtime:/etc/localtime \
    -v $HOME/.irssi:/home/user/.irssi \
    --name irssi \
   cmoultrie/irssi
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

function slack -d "Run slack in a docker"
    docker run --name slack \
    -d \
    -e DISPLAY=172.16.0.1:0 \
    -v ~/tmp:/tmp \
    jess/slack
end

function chrome -d "Run chrome in a docker"
    docker run --name chrome \
    -d \
    -e DISPLAY=172.16.0.1:0 \
    -v ~/Library/Application\ Support/Google/Chrome/:/data \
    jess/chrome
end

function workemail -d "Run a mutt container"
    . ~/.gmailstuff
    docker run -it --rm -v /etc/localtime:/etc/localtime -v $HOME/tmp:/tmp -e GMAIL -e GMAIL_NAME -e GMAIL_PASS -e GMAIL_FROM cmoultrie/mutt
end

function whalesay -d "Run some whalesay"
    docker run -it --rm  docker/whalesay cowsay $argv[1]
end
