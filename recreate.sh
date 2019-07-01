#!/bin/bash

if [ -f ".env_$1" ]
then
    echo "Switching to $1"
    cp .env_$1 .env
    docker-compose build vcs
fi

docker-compose stop
docker-compose rm -f
docker-compose up
