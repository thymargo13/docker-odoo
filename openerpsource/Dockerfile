# a Docker file which purpose is to copy an existing version of source to replicate it inside a container
# Before doing the build, make a link to the actual source directory you want to copy
# ln <your-source-dir> sources

FROM debian:latest
MAINTAINER yves.nicolas@dynamease.com

COPY sources /opt/openerp
VOLUME /opt/openerp
