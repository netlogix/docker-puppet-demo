#!/bin/sh

# Wait till puppet server is available and then run packer
exec wait-for "${PUPPETSERVER_HOSTNAME}:8140" --timeout=60 -- packer-bin "$@"
