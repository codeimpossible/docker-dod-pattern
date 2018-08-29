#!/usr/bin/env sh

. /scripts/vars.sh

set -e

echo "SUB ONE"

ls -lsa /scripts
ls -lsa /dockerfiles
ls -lsa /out

echo "hello from SubContainerOne" >> /out/subone.txt

ls -lsa /out

cat /out/example.txt

docker build \
    --force-rm \
    -f /dockerfiles/SubContainerTwo.dockerfile \
    -t subtwo \
    .

docker run \
    --rm \
    -v $dockerfiles_vol:/dockerfiles \
    -v $out_vol:/out \
    -v $scripts_vol:/scripts \
    -v /var/run/docker.sock:/var/run/docker.sock \
    subtwo