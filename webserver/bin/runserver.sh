#!/bin/bash

# wait for database
exitcode=1
while [[ $exitcode != 0 ]]
do
	echo 'Waiting for database...'
	sleep 1	
	manage.py shell -c "from django.db import connection; connection.ensure_connection()"
	exitcode=$?	
done
echo "Database connected"

# run server
manage.py runserver 0.0.0.0:8080
