FROM docker:18.06

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c", "/scripts/subone.sh"]