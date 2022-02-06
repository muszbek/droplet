#!/bin/bash

source ../postgres/postgres.env
export POSTGRESQL_PASSWORD=$POSTGRESQL_PASSWORD
export POSTGRESQL_USERNAME=$POSTGRESQL_USERNAME
export POSTGRESQL_DATABASE=$POSTGRESQL_DATABASE
export POSTGRESQL_HOST=$POSTGRESQL_HOST

# Wait until Postgres is ready
while ! pg_isready -q -h $POSTGRESQL_HOST -p 5432 -U $POSTGRESQL_USERNAME
do
    echo "$(date) - waiting for database to start..."
    sleep 2
done

mix ecto.migrate
mix run priv/repo/seeds.exs

source ../oauth2/google.secret
export GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID
export GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET

source ../google_maps/api_key.secret
export GOOGLE_API_KEY=$GOOGLE_API_KEY

exec mix phx.server
