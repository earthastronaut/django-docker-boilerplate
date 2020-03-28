#!/bin/bash

username=$1
password=$2

if [[ "$username" == "" || $password == "" ]]
then
	echo 'usage: create_user.sh username password [is_staff]'
	exit 1
fi

if [[ "$3" == "is_staff" ]]
then
	is_staff='True'
else
	is_staff='False'
fi

docker-compose exec webserver \
	django-admin shell \
	--command="from django.contrib.auth.models import User; user=User(username='${username}', is_staff=${is_staff}); user.set_password('${password}'); user.save()"
exitcode=$?
if [[ exitcode == 0 ]]
then
	echo "User Created!"
fi
