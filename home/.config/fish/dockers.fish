function dirssi -d "Run an irssi docker"
    docker run --rm -it -v $HOME/.irssi:/home/user/.irssi --name irssi jess/irssi irssi -n tebriel
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

function workemail -d "Run a mutt container"
    . ~/.gmailstuff
    docker run -it --rm -v /etc/localtime:/etc/localtime -v $HOME/tmp:/tmp -e GMAIL -e GMAIL_NAME -e GMAIL_PASS -e GMAIL_FROM cmoultrie/mutt
end
