#!/bin/bash
set -euo pipefail

secret="${ORIGIN_AUTH_SECRET:-}"
if [ "${#secret}" -lt 32 ]; then
  echo "ORIGIN_AUTH_SECRET must be set and at least 32 characters long" >&2
  exit 1
fi

HASURA_GRAPHQL_METADATA_DATABASE_URL="$DATABASE_URL" graphql-engine \
  serve \
  --server-host 127.0.0.1 \
  --server-port 8080 &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &

# Exit when either process dies so Heroku restarts the dyno.
wait -n
exit 1
