#!/usr/bin/env bash

. ./vars.sh

set -e

docker pull $sharedResourcesImage

# make sure to chmod the files so that _anyone_ can access them
# otherwise we'll have permissions issues when the volumes are mounted
# into another container
docker volume rm $scripts_vol > /dev/null 2>&1 || true
docker volume create $scripts_vol
docker run \
    --name=loader \
    --rm \
    -v $(pwd):/app \
    -v $scripts_vol:/out \
    -t $sharedResourcesImage \
    /bin/sh -c "cp -r /app/*.sh /out && ls -lsa /out && chmod 777 /out/*.*"

# make sure to chmod the files so that _anyone_ can access them
# otherwise we'll have permissions issues when the volumes are mounted
# into another container
docker volume rm $dockerfiles_vol > /dev/null 2>&1 || true
docker volume create $dockerfiles_vol
docker run \
    --name=loader \
    --rm \
    -v $(pwd):/app \
    -v $dockerfiles_vol:/out \
    -t $sharedResourcesImage \
    /bin/sh -c "cp -r /app/*.dockerfile /out && ls -lsa /out && chmod 777 /out/*.*"

docker volume rm $out_vol > /dev/null 2>&1 || true
docker volume create $out_vol

# build the main container
docker build \
    --force-rm \
    -f Main.dockerfile \
    -t main \
    .

# run the main container, this will start sub one and sub two
docker run \
    --rm \
    -v $out_vol:/out \
    -v $scripts_vol:/scripts \
    -v $dockerfiles_vol:/dockerfiles \
    -v /var/run/docker.sock:/var/run/docker.sock \
    main

docker ps
./cleanup.sh