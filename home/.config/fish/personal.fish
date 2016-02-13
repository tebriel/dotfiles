function docker_env -d "Set the docker environment up"
    eval (docker-machine env aws)
end
