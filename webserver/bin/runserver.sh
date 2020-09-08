#!/bin/bash

# wait for database
manage.py wait_for_database

# Apply database migrations
manage.py migrate

# run server
manage.py runserver 0.0.0.0:8080
