#!/bin/bash
# Docker entrypoint script

# Setting generated secrets in env variables
export SECRET_KEY_BASE=$(mix phx.gen.secret)
export SESSION_SIGNING_SALT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8)
export SESSION_CRYPT_SALT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8)
export USER_SIGNING_SALT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8)
export LIVE_SIGNING_SALT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8)

export PHX_HOST=$DOMAIN
export DATABASE_URL=postgres://$POSTGRESQL_USERNAME:$POSTGRESQL_PASSWORD@$POSTGRESQL_HOST:5432/$POSTGRESQL_DATABASE

exec "$@"
