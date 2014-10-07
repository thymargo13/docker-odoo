##
## Dockerfile for a standalone OpenErp environments
## Adapted from main postgresql docker file (see https://registry.hub.docker.com/_/postgres/)
##

FROM ubuntu:14.04
MAINTAINER yves.nicolas@dynamease.com


# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN useradd --home /var/lib/postgresql --create-home postgres

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# install Postgres
#
ENV PG_MAJOR 9.3
RUN apt-get update \
&& apt-get install -y postgresql-common \
&& sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf
RUN apt-get update  && apt-get install -y postgresql-$PG_MAJOR 


# install python libraries required by Openerp
RUN apt-get install -y python-dateutil python-feedparser python-gdata python-ldap \
    python-libxslt1 python-lxml python-mako python-openid python-psycopg2 \
    python-pybabel python-pychart python-pydot python-pyparsing python-reportlab \
    python-simplejson python-tz python-vatnumber python-vobject python-webdav \
    python-werkzeug python-xlwt python-yaml python-zsi python-unittest2 python-mock python-docutils


# clean apt packets
RUN rm -rf /var/lib/apt/lists/*

# Adding the good environment variable
# Adds the executable postgres path to PATH
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
RUN rm /etc/environment \
&& echo PATH=\"$PATH\" >> /etc/environment \
&& echo PGDATA=\"$PGDATA\" >> /etc/environment


# Adding the openerp user
ENV OPENERPUSER erpdynamease
RUN useradd --create-home $OPENERPUSER



