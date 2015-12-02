docker-odoo
==============


A docker image for odoo that enables odoo developpers to easily have the odoo source code and their own modules source code on their PC.
The image is adapted from the official odoo image that can not simply achieve that as the docker file uses the packaged installers.

However you can derive lots of things from the official odoo image howto.

## how to use it

Start a PostgreSQL server

```
$ docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name postgresdb postgres
```

Start the Odoo container
```
$ docker run -p 8069:8069 --name odoo-container --link postgresdb:db -d -v <absolute path to odoo sources>:odoo-sources -v <absolut path to your module sources>:/mnt/extra-addons odoo
```



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

### execute psql command on the database






