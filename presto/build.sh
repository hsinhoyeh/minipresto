#!/bin/bash

set -e

REPONAME=footprintai
PRESTOVER=337

## Build Presto-server
PRESTOIMG=$REPONAME/presto
PRESTOCLIIMG=$REPONAME/presto-cli

docker build --build-arg PRESTO_VER=$PRESTOVER -t $PRESTOIMG -f Dockerfile.presto .
docker push $REPONAME/presto

## Build Presto-CLI

TAG=presto-cli

docker build --build-arg PRESTO_VER=$PRESTOVER -t $PRESTOCLIIMG -f Dockerfile.presto-cli .

# Tag and push to the public docker repository.
docker push $PRESTOCLIIMG


