FROM python:3

# local, dev, stage, or prod
ARG SERVICE_ENVIRONMENT=local 
ENV SERVICE_ENVIRONMENT ${SERVICE_ENVIRONMENT}

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




