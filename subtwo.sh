#!/usr/bin/env sh

. /scripts/vars.sh

set -e

echo "SUB TWO"

ls -lsa /scripts
ls -lsa /dockerfiles
ls -lsa /out

cat /out/example.txt
cat /out/subone.txt