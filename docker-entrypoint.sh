#!/bin/sh
set -ex
./xmrig -o=${POOL_URL} -u=${POOL_USER} -p=${POOL_PW} -k -a rx/wow
exec "$@"
