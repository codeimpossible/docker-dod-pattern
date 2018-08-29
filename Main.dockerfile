FROM docker:18.06

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c", "/scripts/main.sh"]