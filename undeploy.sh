#!/usr/bin/env bash

echo ">> Undeploy aplikasi kontainer..."
docker rm -f $(docker ps -a | grep aaindonesia | awk '{print $1}')
docker rmi -f $(docker images -a | grep aaindonesia | awk '{print $3}')
