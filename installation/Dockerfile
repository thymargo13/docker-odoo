##
## Dockerfile for a standalone OpenErp environments
## Needs git hub to be installed
##

FROM ubuntu:14.04
MAINTAINER yves.nicolas@dynamease.com

RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
	curl nano \
	python-tz python-babel python-dateutil python-psycopg2 \ 
	python-werkzeug python-decorator python-yaml python-unittest2  \
   	python-mako python-jinja2 python-requests python-docutils python-openid \
	python-unidecode python-passlib python-pychart python-psutil python-pypdf \
	python-serial python-reportlab postgresql python-pip python-lxml python-dev \
	python-cups python-xlwt python-bs4 python-unicodecsv vatnumber python-simplejson\
	fontconfig libxrender1 xfonts-75dpi xfonts-base poppler-utils \
	&& curl -o wkhtmltox.deb -SL http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove



# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
# ENV OPENERP_SERVER /etc/odoo/openerp-server.conf

