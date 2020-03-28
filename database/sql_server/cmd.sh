#!/bin/bash
#
# This script runs the sql server and sets up the database if needed. Looks for 
# environment variables:
#
#     * MSSQL_DATABASE_NAME : database_name 
#     * MSSQL_USER : client_user 
#     * MSSQL_PASSWORD : client_password 
#
# a peculiarity of sql server is it needs to be run last so the run_initdb
# function runs asynchronously waiting for the server to start up.
#

set -e

run_initdb() {
	# SQL Command
	cmd="sqlcmd -S localhost -U sa -P $SA_PASSWORD"
	cmd_user="sqlcmd -S localhost -U $MSSQL_USER -P $MSSQL_PASSWORD -d $MSSQL_DATABASE_NAME"

	# Wait for server
	set +e	
	result="Sqlcmd: Error:"
	while [[ $result == *"Sqlcmd: Error:"* ]]
	do
		echo "Waiting for sql server..."
		result="$($cmd -l 1 -Q "SELECT DB_ID('$MSSQL_DATABASE_NAME')" 2>&1)"
		sleep 5
	done


	# Check if need to initialize db
	if [[ $result == *"NULL"* ]]
	then
		echo "Database Initializing"	
		echo "-----------------------"

		echo "CREATE USER $MSSQL_USER"
		echo "-----------------------"
		$cmd -Q "CREATE LOGIN $MSSQL_USER WITH PASSWORD = '$MSSQL_PASSWORD'"
		$cmd -Q "GRANT VIEW SERVER STATE TO $MSSQL_USER"

		echo "CREATE DATABASE $MSSQL_DATABASE_NAME"
		echo "-----------------------"
		$cmd -Q "CREATE DATABASE $MSSQL_DATABASE_NAME"

		echo "GRANT USER PERMISSIONS ON DATABASE"
		echo "-----------------------"
		$cmd -d $MSSQL_DATABASE_NAME -Q "
			CREATE USER $MSSQL_USER FOR LOGIN $MSSQL_USER;
			GRANT SELECT, INSERT, UPDATE, DELETE, ALTER, CREATE TABLE, REFERENCES, EXEC TO $MSSQL_USER;
		"

		entrypoint_initdb_d="/opt/app/initialize_database"
		echo "INITIALIZE SCRIPTS FROM ${entrypoint_initdb_d} AS ${MSSQL_USER}"	
		echo "-----------------------"
		for filepath in ${entrypoint_initdb_d}/*.sql
		do			
			echo "execute script: $filepath"
			$cmd_user -i $filepath
		done

		echo "Database Initialized"	
	else
		echo "Database Found $MSSQL_DATABASE_NAME"
	fi

	# TO DROP
	# cmd="/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD}"
	# $cmd -Q "DROP DATABASE $MSSQL_DATABASE_NAME"
	# $cmd -Q "DROP LOGIN $MSSQL_USER"
}

run_initdb & /opt/mssql/bin/sqlservr
