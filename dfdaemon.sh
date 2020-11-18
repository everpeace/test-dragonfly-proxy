#! /bin/sh

dfdaemon --config /dfdaemon.yml &

HTTP_PROXY=http://localhost:65001 HTTPS_PROXY=http://localhost:65001 dockerd
