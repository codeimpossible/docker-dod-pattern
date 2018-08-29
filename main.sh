#!/usr/bin/env sh

cd "${0%/*}"
scriptDir="$(pwd)"

. ./vars.sh

set -e

echo "MAIN"

ls -lsa /scripts
ls -lsa /dockerfiles
ls -lsa /out

# write a simple file to the out volume
echo "hello" >> /out/example.txt

ls -lsa /out

docker build \
    --force-rm \
    -f /dockerfiles/SubContainerOne.dockerfile \
    -t subone \
    .

docker run \
    --rm \
    -v $dockerfiles_vol:/dockerfiles \
    -v $out_vol:/out \
    -v $scripts_vol:/scripts \
    -v /var/run/docker.sock:/var/run/docker.sock \
    subone