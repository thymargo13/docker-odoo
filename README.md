docker-odoo
==============


A docker image for odoo that enables odoo developpers to easily have the odoo source code and their own modules source code on their PC.
The image is adapted from the official odoo image that can not simply achieve that as the docker file uses the packaged installers.

However you can derive lots of things from the official odoo image howto.

## Supported tags and respective `Dockerfile` links :

* `latest` [Dockerfile](https://github.com/yvnicolas/docker-odoo/blob/master/Dockerfile)

## how to use it

### odoo sources git preparation

Whereever you want to locate them
```
git clone https://github.com/odoo/odoo.git
# the image is suitable for odoo 8
git checkout 8.0  # or what ever sub branch you want to use
```

### Starting containers

Start a PostgreSQL server

```
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name postgresdb postgres
```

Start the Odoo container
```
docker run-d  -p 8069:8069 --name odoo-container --link postgresdb:db  -v <absolute path to odoo sources>:/opt/odoo/sources -v <absolute path to your module sources>:/mnt/extra-addons odoo yvnicolas/odoo
```

All odoo options added at the end of the `docker run` line will be passed to odoo.
Default config file used for launch is `/opt/odoo/openerp-server.conf`
You need to have at least one module in extra-addons otherwise your container will fail. (you can also remedy that by changing the conf file and suppressing the `/mnt/extra-addons` part of the addons line

### Networking configurations

the `--link` option is the old way that docker initially used to link containers together. They do not guarantee support for the long term for that. The preferred way to go is to use the `docker network`
features, although this image still works fine with it.

With a bit of simplification, the docker networking feature enables to create containers networks in which a DNS feature will automatically resolve IP adresses with containers names.

After you create your postgres containers, create a network and connect your database to it :
```
docker network create odoonet
docker network connect odoonet postgresdb
```
Then when you launch your odoo container replace the `--link postgresdb:db` option with `-e "HOST=postgresdb" --network=odoonet`. The `-e` part sets up the HOST environment variable to the db container name which the image links to the `db_host` odoo configuration variable and the `--network` part would be equivalent for the container to a `docker network connect odoonet` command.

## A few how tos

### get running logs on servers

```
docker logs -f odoo-container
```

### get inside the container
Pay attention you have no root access inside this container
```
docker exec -ti odoo-container bash
```

### postgres console into the database
```
docker exec -ti postgresdb su -c psql postgres
```

### populate the data base with a preexisting dum

```
docker exec -ti postgresdb su postgres
# first create the db owned by odoo postgres user
createdb -O odoo <database name>
# then restore the dump (you need to have the dump file accessible from your postgres container)
pg_restore -d <database name> -Fc <path to dump file>
```




