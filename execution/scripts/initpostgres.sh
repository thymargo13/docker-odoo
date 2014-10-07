#!/bin/bash

# Make the necessary permissions changes for postgres data volume
# and initiates the database if not done yet
set -e

chown -R postgres:postgres "$PGDATA"


# if PGDATA repertory is empty, it needs to be initialized and the appropriate openerp user to be created
# this part also changes the postgres network configuration so that openerp can access the postgres database inside the container

if [ -z "$(ls -A "$PGDATA")" ]; then
    su postgres -c 'initdb'
    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf
    { echo; echo 'host all all 0.0.0.0/0 trust'; } >> "$PGDATA"/pg_hba.conf

    su postgres -c "pg_ctl start -l /var/lib/postgresql/logpostgres"
    #sleep is ncessary here to wait for postgres to be ready to accept connections
    sleep 1
    su postgres -c "createuser -s $OPENERPUSER"

# else just start the server
else
    su postgres -c "pg_ctl start -l /var/lib/postgresql/logpostgres"

fi

# Lancer Openerp
su $OPENERPUSER -c "/opt/openerp/server/openerp-server -c /home/$OPENERPUSER/openerp.conf > /home/$OPENERPUSER/openerplog&"

# run commands that have been passed at the docker run level
exec "$@"
