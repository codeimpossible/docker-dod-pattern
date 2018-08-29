#!/usr/bin/env sh

cd "${0%/*}"
scriptDir="$(pwd)"

set -e

. ./vars.sh

docker image rm subtwo
docker image rm subone
docker image rm main

docker volume rm $scripts_vol || true
docker volume rm $dockerfiles_vol || true
docker volume rm $out_vol|| true