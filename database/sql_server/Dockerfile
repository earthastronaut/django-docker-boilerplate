# https://hub.docker.com/_/microsoft-mssql-server

# 2017-latest: pyodbc==4.0.17 only supports
# _sql_server_versions = {
#     9: 2005,
#     10: 2008,
#     11: 2012,
#     12: 2014,
#     13: 2016,
#     14: 2017,
# }
FROM mcr.microsoft.com/mssql/server:2017-latest

ENV ACCEPT_EULA "Y"
ENV MSSQL_PID "Express"
ENV PATH "/opt/mssql-tools/bin:$PATH"

WORKDIR /opt/app
COPY . .

CMD ["/opt/app/cmd.sh"]

HEALTHCHECK CMD ["/opt/app/healthcheck.sh"]
