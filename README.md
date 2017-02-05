# What do we need?

- JMXtrans: provided by this image
- A backend such as Graphite: I recommand using [`nickstenning/graphite`](https://github.com/nickstenning/docker-graphite).

# How to build the image

```
$ git https://github.com/chtefi/jmxtrans-docker
$ cd jmxtrans-docker
$ docker build -t chtefi/jmxtrans:latest .
```

We can see our new image:

```
$ docker images chtefi/jmxtrans
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
chtefi/jmxtrans     latest              c17b9838505c        5 hours ago         178 MB
```

The image provides 2 volumes (and does not expose any port):

- `/opt/jmxtrans/conf`
- `/opt/jmxtrans/logs` (optional)

# Start the containers

- Start our JMXTrans image.

We need to provide some conf and we can add a volume binding to get the logs (optional):

```
$ ls jmxtrans_conf
jmxtrans.conf
$ docker run -d --name jmxtrans -v c:/tmp/jmxtrans-docker/jmxtrans_log:/opt/jmxtrans/log -v c:/tmp/jmxtrans-docker/jmxtrans_conf:/opt/jmxtrans/conf chtefi/jmxtrans
```

If the configuration is all right (looking at the logs), we can start Graphite to store the metrics and display them.

- Start Graphite + Carbon.

This image expose 4 ports but only 2 are interesting for us: 80 for the interface, and 2003 to send our metrics.
```
$ docker run -p 8080:80 -p 2003:2003 -d nickstenning/graphite
```

If we connect to http://localhost:8080/, we can see the Graphite UI without metrics, a few seconds later, some `carbon` metrics will appears (automatic).

If jmxtrans was started, then we'll see our metrics too.


