- remove ecto references from phoenix so it compiles
- docker-compose file for couchdb
- bash script for couchdb migrations
- set up couchdb connection in phoenix
- unit test framework for nosql couchdb (no ecto)
...
OAUTH2

docker run -e COUCHDB_USER=droplet -e COUCHDB_PASSWORD=droplet --name couchdb couchdb:3.2.1
