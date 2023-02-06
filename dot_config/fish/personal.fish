function docker_env -d "Set the docker environment up"
    eval (docker-machine env aws)
    set -gx DOCKER_TLS_VERIFY $DOCKER_TLS_VERIFY;
    set -gx DOCKER_HOST $DOCKER_HOST;
    set -gx DOCKER_CERT_PATH $DOCKER_CERT_PATH;
    set -gx DOCKER_MACHINE_NAME $DOCKER_MACHINE_NAME;
end
