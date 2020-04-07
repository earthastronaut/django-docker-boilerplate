#!/bin/bash

username=$1
password=$2

if [[ "$username" == "" || $password == "" ]]
then
	echo 'usage: create_user.sh username password usertype'
	exit 1
fi

if [[ "$3" == "staff" ]]
then
	is_staff='True'
	is_superuser='False'
elif [[ "$3" == "superuser" ]]
then
	is_staff='True'
	is_superuser='True'
elif [[ "$3" == "regular" ]]
then
	is_staff='False'
	is_superuser='False'
else
	echo 'User type must be: regular, staff, superuser'

fi


wait_for_database.sh

django-admin shell \
	--command="from django.contrib.auth.models import User; user=User(username='${username}', is_staff=${is_staff}, is_superuser=${is_superuser}); user.set_password('${password}'); user.save()"

exitcode=$?

if [[ $exitcode == 0 ]]
then
	echo "User Created"
fi
