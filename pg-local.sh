#!/bin/bash

display_help() {
    echo "=================================================="
    echo "             Postgres Playround!                  "
    echo "=================================================="
    echo "Syntax: ./pg-local.sh [command]"
    echo
    echo "---commands---"
    echo "help             Print CLI help"
    echo "pull             Pull the latest PostGres image from DockerHub"
    echo "create           Start up and expose the database!"
    echo "start            Run an instance you have stopped"
    echo "stop             Spin down the database"
    echo "destroy          Delete the DB container"
    echo "prompt           Start an interactive psql prompt in the container"
    echo "execute          Execute a sql file - must be in sql/ dir"
    echo
}

[ -f .env ] && source .env
DEFAULT_DATABASE=${DATABASE_NAME:-dev}

case "$1" in
pull)
    docker pull postgres
    ;;
create)
    docker run -d \
    -p 5432:5432 \
    --name pg-local \
    -e POSTGRES_PASSWORD=postgres \
    --volume "$PWD"/sql:/usr/src/sql \
    --volume "$PWD"/data:/usr/src/data \
    postgres

    echo "Waiting for PostGres container to come online..."
    sleep 3
    echo "Creating default DB '${DEFAULT_DATABASE}'..."
    docker exec -it pg-local psql -U postgres -c "CREATE DATABASE ${DEFAULT_DATABASE};"
    ;;
start)
    docker start pg-local
    ;;
stop)
    docker stop pg-local
    ;;
destroy)
    docker rm -f pg-local
    ;;
prompt)
    docker exec -it pg-local \
        psql \
        -U postgres \
        -d "${DEFAULT_DATABASE}"
    ;;
execute)
    docker exec -it pg-local \
        psql \
        -U postgres \
        -d "${DEFAULT_DATABASE}" \
        -f "/usr/src/sql/$2"
    ;;
help)
    display_help
    ;;
*)
    echo "No command specified, displaying help"
    display_help
    ;;
esac
