#!/bin/bash

source ../couchdb/couchdb.env
# Wait until CouchDB is ready
while ! curl --silent --fail -o /dev/null $COUCHDB_HOST:5984/
do
    echo "$(date) - waiting for database to start..."
    sleep 2
done

DB_ADDRESS=http://$COUCHDB_USER:$COUCHDB_PASSWORD@$COUCHDB_HOST:5984

if ! curl -s -f -o /dev/null $DB_ADDRESS/_users; then
    echo "$(date) - adding _users database..."
    curl -X PUT -s -o /dev/null $DB_ADDRESS/_users
fi

if ! curl -s -f -o /dev/null $DB_ADDRESS/droplet; then
    echo "$(date) - adding droplet database..."
    curl -X PUT -s -o /dev/null $DB_ADDRESS/droplet
fi

source ../oauth2/google.secret
export GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID
export GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET

exec mix phx.server
