##
## Dockerfile for a standalone OpenErp environments
## Adapted from main postgresql docker file
##

FROM f436cab7f53e
MAINTAINER yves.nicolas@dynamease.com


COPY scripts/ /usr/local/sbin

RUN chmod ugo+x /usr/local/sbin/*

RUN rm /etc/environment \
&& echo PATH=\"$PATH\" >> /etc/environment \
&& echo PGDATA=\"$PGDATA\" >> /etc/environment 

# init database
ENTRYPOINT ["/usr/local/sbin/initpostgres.sh"]

