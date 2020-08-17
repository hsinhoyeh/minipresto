#!/bin/bash

set -e

REPONAME=footprintai
TAG=hive-metastore

docker build -t $REPONAME/$TAG .

# Tag and push to the public docker repository.
docker push $REPONAME/$TAG
