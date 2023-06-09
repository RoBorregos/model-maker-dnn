#!/bin/bash

# Variables required for logging as a user with the same id as the user running this script
export LOCAL_USER_ID=`id -u $USER`
export LOCAL_GROUP_ID=`id -g $USER`
export LOCAL_GROUP_NAME=`id -gn $USER`
DOCKER_USER_ARGS="--env LOCAL_USER_ID --env LOCAL_GROUP_ID --env LOCAL_GROUP_NAME"

# Variables for forwarding ssh agent into docker container
SSH_AUTH_ARGS=""
if [ ! -z $SSH_AUTH_SOCK ]; then
    DOCKER_SSH_AUTH_ARGS="-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi

DOCKER_NETWORK_ARGS="--net host"
if [[ "$@" == *"--net "* ]]; then
    DOCKER_NETWORK_ARGS=""
fi

DOCKER_COMMAND="docker run"

ADDITIONAL_COMMANDS=""
xhost +

$DOCKER_COMMAND -it -d\
    $DOCKER_USER_ARGS \
    $DOCKER_SSH_AUTH_ARGS \
    $DOCKER_NETWORK_ARGS \
    $ADDITIONAL_COMMANDS \
    --privileged \
    -v "$PWD/" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name=ivansin \
    model-maker \
    bash

#cat << EOF	