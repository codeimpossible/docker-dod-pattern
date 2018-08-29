FROM alpine:3.8

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c", "/scripts/subtwo.sh"]