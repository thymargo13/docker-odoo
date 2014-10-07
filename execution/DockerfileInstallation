##
## Dockerfile for a standalone OpenErp environments
## Adapted from main postgresql docker file
##

FROM ubuntu:14.04
MAINTAINER yves.nicolas@dynamease.com


# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN useradd --home /var/lib/postgresql --create-home postgres

# grab gosu for easy step-down from root
#RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
#&& curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
#&& chmod +x /usr/local/bin/gosu \
#&& apt-get purge -y --auto-remove curl

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
RUN apt-get update  && apt-get install -y postgresql-$PG_MAJOR \
&& rm -rf /var/lib/apt/lists/*

# Adding the good environment variable
# Adds the executable postgres path to PATH
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
RUN rm /etc/environment \
&& echo PATH=\"$PATH\" >> /etc/environment \
&& echo PGDATA=\"$PGDATA\" >> /etc/environment


# NAME of the openerp user
ENV OPENERPUSER erpdynamease
RUN useradd --create-home $OPENERPUSER

# Copy scripts in /usr/local/sbin and make them executable
COPY scripts/ /usr/local/sbin

RUN chmod ugo+x /usr/local/sbin/*

# init database
#ENTRYPOINT ["/usr/local/sbin/initpostgres.sh"

