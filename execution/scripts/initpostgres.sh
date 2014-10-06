#!/bin/bash

# Make the necessary permissions changes for postgres data volume
# and initiates the database if not done yet
set -e

chown -R postgres:postgres "$PGDATA"


# if PGDATA repertory is empty, it needs to be initialized and the appropriate dopenerp user to be created
# this part also changes the postgres network configuration so that openerp can access the postgres database inside the container

if [ -z "$(ls -A "$PGDATA")" ]; then
    gosu postgres initdb
    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf
    { echo; echo 'host all all 0.0.0.0/0 trust'; } >> "$PGDATA"/pg_hba.conf

    useradd -r $OPENERPUSER
    su postgres -c "createuser -s $OPENERPUSER"
fi

 useradd -r $OPENERPUSER
 su postgres -c "pg_ctl start -l /var/logs/logpostgres"
 su postgres -c "createuser -s $OPENERPUSER"
exec "$@"