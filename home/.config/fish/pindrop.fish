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

function get_aws_ip -d "Get the ip address for an AWS instance by ID"
    aws ec2 describe-instances --instance-ids=$argv[1] | jq '.Reservations[0].Instances[0].NetworkInterfaces[0].PrivateIpAddresses[0].PrivateIpAddress' \
        | sed 's|"||g'
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
    # eval (docker-machine env dev)
    # set -gx DOCKER_TLS_VERIFY $DOCKER_TLS_VERIFY;
    # set -gx DOCKER_HOST $DOCKER_HOST;
    # set -gx DOCKER_CERT_PATH $DOCKER_CERT_PATH;
    # set -gx DOCKER_MACHINE_NAME $DOCKER_MACHINE_NAME;
end

function go_env -d "Set go environment variables"
    # Set up go environment
    set -gx GOPATH $HOME/work
    set PATH /usr/local/go/bin ~/bin $GOPATH/bin $PATH
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

function docker_api -d "Hit up the narsil docker api for things"
    curl -k -H "Authorization: Basic "(jq -r '.["auths"]["narsil.ad.pdrop.net:5000"]["auth"]' ~/.docker/config.json) https://narsil.ad.pdrop.net:5000/v2/"$argv[1]" -s | python -mjson.tool
end

function extra_funcs -d "Extra configuration functions"
    rbenv_env
end

function kenv -d "Pick a kube env"
    switch (echo $argv[1])
    case 'dev'
        kubectl config use-context dev
    case 'staging'
        kubectl config set-context staging --namespace=ivr-auth-master
        kubectl config use-context staging
    case 'pre-prod'
        kubectl config set-context staging --namespace=ivr-auth-pre-prod
        kubectl config use-context staging
    case 'load'
        kubectl config set-context staging --namespace=ivr-auth-load-test
        kubectl config use-context staging
    case 'prod'
        kubectl config use-context prod
    end
end

function kget -d "Get things from kube"
    kubectl get $argv
end

function kdesc -d "Describe things in kube"
    kubectl describe $argv
end
