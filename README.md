# DJANGO DEMO FUN!

This code is meant as an example of a Django project.


# Getting Started

1. Install Docker and Docker Compose
1. Build the containers `docker-compose build`
1. Run the Django migrations for the database `docker-compose run --rm webserver manage.py migrate`
1. Create a user, can use this handy script `/webserver/scripts/create_user.sh me strongpassword`
1. Start the containers `docker-compose up` (or `cmd up`)
1. Go to [localhost:8000](http://localhost:8000) to view!
