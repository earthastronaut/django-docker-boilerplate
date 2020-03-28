#!/bin/bash

username=$1

if [[ "$username" == "" ]]
then
	echo 'usage: delete_user.sh username'
	exit 1
fi

docker-compose exec webserver \
	django-admin shell \
	--command="from django.contrib.auth.models import User; User.objects.get(username='${username}').delete()"
exitcode=$?

if [[ $exitcode == 0 ]]
then
	echo "User Deleted"
fi
