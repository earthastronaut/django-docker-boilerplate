#!/bin/bash
set -e

sqlcmd \
	-S localhost \
	-U $MSSQL_USER \
	-P $MSSQL_PASSWORD \
	-d $MSSQL_DATABASE_NAME \
	-Q 'SELECT 1'
