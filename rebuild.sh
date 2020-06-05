#!/bin/bash

docker build . -t sniffer:env
docker rm -f `docker ps -aq`
docker-compose up -d