# Mapproxy for Docker

## Supported tags

* `1.15.1`, `1.15.1-alpine`

## What is MapProxy

[MapProxy](https://mapproxy.org/) is an open source proxy for geospatial data. It caches, accelerates and transforms
data from existing map services and serves any desktop or web GIS client.

## Run container

You can run the container with a command like this:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 jingsam/mapproxy
```

*It is optional, but recommended to add a volume. Within the volume mapproxy get the configuration, or create one
automatically. Cached tiles will be stored also into this volume.*

The container normally runs in [http-socket-mode](http://uwsgi-docs.readthedocs.io/en/latest/HTTP.html). If you will not
run the image behind a HTTP-Proxy, like [Nginx](http://nginx.org/), you can run it in direct http-mode by running:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 jingsam/mapproxy mapproxy http
```

### Environment variables

* `MAPPROXY_PROCESSES` default: 4
* `MAPPROXY_THREADS` default: 2

## Enhance the image

You can put a `mapproxy.yaml` into the `/docker-entrypoint-initmapproxy.d` folder on the image. On startup this will be
used as MapProxy configuration. Attention, this will override an existing configuration in the volume!

Additional you can put shell-scripts, with `.sh`-suffix in that folder. They get executed on container startup.

You should use the `mapproxy` user within the container, especially not `root`!
