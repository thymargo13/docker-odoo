##
## Dockerfile for a standalone OpenErp environments
## 
##

FROM openerp/installation
MAINTAINER yves.nicolas@dynamease.com


# Import in container needed executable scripts and make them executable

COPY scripts/ /usr/local/sbin
RUN chmod ugo+x /usr/local/sbin/*

# copy base configuration for openerp
COPY openerp.conf /home/$OPENERPUSER/

# Maxe openerp accessible from the outside
EXPOSE 8069

# init execution
ENTRYPOINT ["/usr/local/sbin/initpostgres.sh"]

