ARG PYTHON_VERSION=3.9
ARG MAPPROXY_VERSION=1.15.1

FROM python:${PYTHON_VERSION}-slim-bullseye

ARG MAPPROXY_VERSION
ENV MAPPROXY_PROCESSES 4
ENV MAPPROXY_THREADS 2

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
  && pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple

RUN set -x \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    libgeos-dev \
    libgdal-dev \
    python3-lxml \
    python3-shapely \
    uwsgi \
    uwsgi-plugin-python3 \
  && rm -rf /var/lib/apt/lists/* \
  && pip install Pillow PyYAML pyproj six MapProxy==${MAPPROXY_VERSION}  \
  && useradd -ms /bin/bash mapproxy \
  && mkdir -p /mapproxy \
  && chown mapproxy /mapproxy \
  && mkdir -p /docker-entrypoint-initmapproxy.d

USER mapproxy
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mapproxy"]

VOLUME ["/mapproxy"]
EXPOSE 8080
EXPOSE 9191