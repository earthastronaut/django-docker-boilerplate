#!/bin/bash

# requirements.txt which has unfixed dependency versions
requirements=$1

# requirements_freeze.txt has fixed dependency versions
requirements_freeze=$2

# ########################################################################### #
# intro

echo "---------------------------"
echo "Install Python Requirements"
echo "---------------------------"
echo "SERVICE_ENVIRONMENT=$SERVICE_ENVIRONMENT"
echo "requirements=$requirements"
echo "requirements_freeze=$requirements_freeze"
echo "---------------------------"


# ########################################################################### #
# install

pip install -U pip setuptools wheel

if [[ "$SERVICE_ENVIRONMENT" == "local"  || "$SERVICE_ENVIRONMENT" == "dev" ]]
then
	pip install -r $requirements

elif [[ "$SERVICE_ENVIRONMENT" == "stage" || "$SERVICE_ENVIRONMENT" == "prod" ]]
then
	pip install -r $requirements_freeze

else
	echo "unknown SERVICE_ENVIRONMENT=${SERVICE_ENVIRONMENT}" >&2 
	exit 1
fi

# ########################################################################### #
# verify that requirements installed are correct

pip freeze > /tmp/install_current_pip_freeze.txt

diff --strip-trailing-cr /tmp/install_current_pip_freeze.txt $requirements_freeze > /tmp/install_diff.txt 2>&1
exitcode=$?

echo "---------------------------"
echo "current pip freeze"
echo "---------------------------"
cat /tmp/install_current_pip_freeze.txt

echo "---------------------------"
echo "requirements diff"
echo "---------------------------"
cat /tmp/install_diff.txt

exit $exitcode
