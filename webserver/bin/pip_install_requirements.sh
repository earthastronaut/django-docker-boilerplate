#!/bin/bash

set -e 

# Usage: 
# 	pip_install_requirements requirements_dir

requirements_dir="$1"

# ########################################################################### #
# Select Requirements File
# ########################################################################### #

case "$SERVICE_ENVIRONMENT" in
	"local" ) 	requirements_file=local.txt
		;;
	"dev" ) 	requirements_file=dev.txt
		;;
	"stage" ) 	requirements_file=stage.txt
		;;
	"prod" ) 	requirements_file=prod.txt
		;;
	"local" ) 	requirements_file=local.txt
		;;
	* )
		echo "unknown SERVICE_ENVIRONMENT=${SERVICE_ENVIRONMENT}" >&2 
		exit 1
	;;
esac

requirements_filepath="$requirements_dir"/"$requirements_file"

# ########################################################################### #
# Install Requirements
# ########################################################################### #

echo "---------------------------"
echo "Install Python Requirements"
echo "---------------------------"
echo "SERVICE_ENVIRONMENT=$SERVICE_ENVIRONMENT"
echo "requirements=$requirements_filepath"
echo "---------------------------"

pip install -U pip setuptools wheel
pip install -r $requirements_filepath

# ########################################################################### #
# Check for Update to Requirements
# ########################################################################### #

echo "---------------------------"
echo "Check Python Requirements"
echo "---------------------------"
pip list --outdated

# ########################################################################### #
# Print out current pip freeze
# ########################################################################### #

echo "---------------------------"
echo "Current pip freeze"
echo "---------------------------"
pip freeze
echo "---------------------------"