#!env bash
echo $0

PROJECT_DIR=$(dirname "$(readlink "$0")")
usage="usage: $(basename "$0") <command> 

This script helps with simple command shortcuts for development. 

NOT RECOMMENDED TO USE THESE FOR PRODUCTION. USE ./scripts/prod FOR 
SCRIPTS NEEDED BY DOWNSTREAM BUILD SERVICES.


general helper commands 
	link_me		Link this cmd to /usr/local/bin/cmd

docker helper commands 
	up          Wrapper for docker-compose up
	run 		Wrapper for docker-compose run
	exec  		Wrapper for docker-compose exec
	quickstart	Build and initialize the project 	

webserver helper commands
	bash       	Start a bash shell in the server as exec
	shell		Start a django shell as exec
	manage.py	Run python manage.py <arguments> as exec fallback to run

"

# ---------------------------------------------------------------------------- #
# Take the input command

case "$1" in

# ---------------------------------------------------------------------------- #
# docker helper commands 
up)
	docker-compose up --remove-orphans --no-recreate ${@:2}
	exit 
	;;

run)
	docker-compose run --rm ${@:2}
	exit
	;;

exec)
	docker-compose exec ${@:2}
	exit 
	;;

quickstart):
	echo '----------------------------'
	echo 'Build Images'
	echo '----------------------------'
	docker-compose build

	echo '----------------------------'
	echo 'Start Images'
	echo '----------------------------'
	docker-compose up -d webserver
	# wait for started
	docker-compose exec webserver wait_for_database.sh

	echo '----------------------------'
	echo 'Run Migrations'
	echo '----------------------------'
	docker-compose exec webserver manage.py migrate

	# echo '----------------------------'
	# echo 'Create Admin User'
	# echo '----------------------------'
	# echo 'WARNING: creating admin user. Should probably delete.'
	# docker-compose exec webserver bash -c 'scripts/create_user.sh admin admin superuser 2> /dev/null'

	echo '----------------------------'
	echo 'Collectstatic'
	echo '----------------------------'	
	docker-compose exec webserver manage.py collectstatic --no-input

	echo '----------------------------'
	echo 'Restart Images Attached'
	echo '----------------------------'	
	docker-compose stop webserver
	docker-compose up webserver

	;;


# ---------------------------------------------------------------------------- #
# webserver helper commands

bash)
	docker-compose exec webserver bash
	exit
	;;


shell)
	docker-compose exec webserver manage.py shell
	exit
	;;


manage.py)
	docker-compose exec webserver manage.py ${@:2} 2> /dev/null
	exitcode=$?
	if [[ $exitcode == 1 ]]
	then
		echo "No container webserver found, executing with 'run'"
		docker-compose run --rm webserver manage.py ${@:2}
	fi
	exit
	;;

createuser)
	webserver/scripts/create_user.sh ${@:2}
	exit
	;;

deleteuser)
	webserver/scripts/delete_user.sh ${@:2}
	exit
	;;

# ---------------------------------------------------------------------------- #
# defaults

*) printf "illegal option: $1\n\n" >&2
	echo "$usage" >&2
	exit 1
	;;

esac
