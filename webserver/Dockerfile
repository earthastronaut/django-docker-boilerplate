FROM python:3

# local, dev, stage, or prod
ARG SERVICE_ENVIRONMENT=local 
ENV SERVICE_ENVIRONMENT ${SERVICE_ENVIRONMENT}

# ########################################################################### #
# For SQL Server
# ########################################################################### #
# Reference: https://docs.microsoft.com/en-us/sql/connect/odbc/linux/installing-the-microsoft-odbc-driver-for-sql-server-on-linux
# Note that python:3 uses a debian and I searched https://packages.microsoft.com/config/ for the correct version
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y \
	unixodbc-dev \
	mssql-tools

RUN cp /opt/microsoft/msodbcsql17/etc/odbcinst.ini /etc/odbcinst.ini
RUN cat /etc/odbcinst.ini

# ########################################################################### #
# Build Django Project
# ########################################################################### #
ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH "/code:/code/apps:$PYTHONPATH"
ENV PATH "/code/bin:$PATH"

WORKDIR /code/bin

COPY bin/pip_install_requirements.sh .

WORKDIR /code

# Python Requirements
COPY requirements.txt .
COPY requirements_freeze.txt .
RUN pip_install_requirements.sh requirements.txt requirements_freeze.txt

# copy all code over
COPY . .

EXPOSE 8080
CMD ["runserver.sh"]




