# test-dragonfly-proxy

This creates experimental environment for caching `quay.io` images by docker compose.

- `1` supernode
- `2 d`fdaemons (with docker daemon to use each dfdaemon as proxy)

```shell
$ git clone https://github.com/everpeace/test-dragonfly-proxy.git
$ docker-compose up
...
# press Ctrl-C to shutdown
```

In another terminal, please try to pull a sample image in `dfdaemon1`:

```shell
$ docker-compose exec dfdaemon1 time docker pull quay.io/everpeace/alpine:latest
latest: Pulling from everpeace/alpine
188c0c94c7c5: Pull complete
Digest: sha256:d7342993700f8cd7aba8496c2d0e57be0666e80b4c441925fc6f9361fa81d10e
Status: Downloaded newer image for quay.io/everpeace/alpine:latest
quay.io/everpeace/alpine:latest
real    0m 58.95s
user    0m 0.04s
sys     0m 0.02s
```

you'll see below dfdaemon logs:

```text
dfdaemon1_1  | 2020-11-18 04:42:15.992 INFO sign:17 : start download url:https://quay.io/v2/everpeace/alpine/blobs/sha256:d6e46aa2470df1d32034c6707c8041158b652f38d2a9ae3d7ad7e7532d22ebe0 to f8dc35f1-1726-46f8-ae54-775d7a5431d9 in repo
dfdaemon1_1  | 2020-11-18 04:42:16.001 INFO sign:17 : start download url:https://quay.io/v2/everpeace/alpine/blobs/sha256:188c0c94c7c576fff0792aca7ec73d67a2f7f4cb3a6e53a84559337260b36964 to abb094a6-f76e-4230-a51b-39e5d25eb661 in repo
dfdaemon1_1  | 2020-11-18 04:42:27.733 INFO sign:17 : dfget url:https://quay.io/v2/everpeace/alpine/blobs/sha256:d6e46aa2470df1d32034c6707c8041158b652f38d2a9ae3d7ad7e7532d22ebe0 [SUCCESS] cost:11.762s
dfdaemon1_1  | 2020-11-18 04:43:10.345 INFO sign:17 : dfget url:https://quay.io/v2/everpeace/alpine/blobs/sha256:188c0c94c7c576fff0792aca7ec73d67a2f7f4cb3a6e53a84559337260b36964 [SUCCESS] cost:54.386s
dfdaemon1_1  | 2020-11-18 04:43:21.467 INFO sign:17 : scan repo and clean expired files
...
```

It is expected that `docker pull` in `dfdeamon2` makes it faster because dragonfly already cached. However, it takes almost the same time.

```shell
$ docker-compose exec dfdaemon2 time docker pull quay.io/everpeace/alpine:latest
latest: Pulling from everpeace/alpine
188c0c94c7c5: Pull complete
Digest: sha256:d7342993700f8cd7aba8496c2d0e57be0666e80b4c441925fc6f9361fa81d10e
Status: Downloaded newer image for quay.io/everpeace/alpine:latest
quay.io/everpeace/alpine:latest
real    0m 58.25s
user    0m 0.03s
sys     0m 0.02s
```
