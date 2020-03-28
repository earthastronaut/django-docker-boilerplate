# https://hub.docker.com/_/postgres
FROM postgres:latest

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb

COPY healthcheck.sh /usr/local/bin/
HEALTHCHECK CMD ["/usr/local/healthcheck.sh"]
