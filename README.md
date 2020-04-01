# Django Boilerplate Fun!

This code is meant as an example of a Django project.


## Features

* dockerized services which work together
* django docker build for different environments
* django docker build with floating and fixed requirement versions
* postgres docker service for django
* mssql sql-server docker service for django


# Starting the Demo

1. Install [Docker](https://docs.docker.com/docker-for-mac/install/) and 
	[docker-compose](https://docs.docker.com/compose/install/).1. Build the containers `docker-compose build`
1. Run the Django migrations for the database `docker-compose run --rm webserver manage.py migrate`
1. Create a user, can use this handy script `/webserver/scripts/create_user.sh me strongpassword`
1. Start the containers `docker-compose up` (or `cmd up`)
1. Go to [localhost:8000](http://localhost:8000) to view!


# Starting a Project

I recommend starting from this and removing the databases backends you are not using. 


