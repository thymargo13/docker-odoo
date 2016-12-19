##
## Dockerfile for a standalone OpenErp environments
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
        python-cups python-xlwt python-bs4 python-unicodecsv python-vatnumber python-simplejson\
	python-pil python-zsi python-pyinotify python-renderpm python-support\
	fontconfig libxrender1 xfonts-75dpi xfonts-base poppler-utils \
        && curl -o wkhtmltox.deb -SL http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove


# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
COPY openerp-server.conf /opt/odoo/
COPY entrypoint.sh /
ENV OPENERP_SERVER /opt/odoo/openerp-server.conf

 # explicitly set user/group IDs
RUN groupadd -r odoo --gid=1000 && useradd -r -g odoo --uid=1000 odoo

# Appropriate directory creation and right changes
RUN mkdir /var/lib/odoo \
    && chown odoo:odoo /var/lib/odoo \
    && chown -R odoo:odoo /opt\
    && chmod ugo+x /entrypoint.sh \
    && chown odoo:odoo /entrypoint.sh

VOLUME ["/var/lib/odoo", "/mnt", "/opt/odoo"]
USER odoo


ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c", "/opt/odoo/openerp-server.conf"]

