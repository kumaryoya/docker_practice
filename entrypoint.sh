#!/bin/bash
set -e
rm -f /cw_app/tmp/pids/server.pid
exec "$@"
