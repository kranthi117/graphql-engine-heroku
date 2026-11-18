FROM caddy:2.8.4 AS caddy

FROM hasura/graphql-engine:v2.17.0

COPY --from=caddy /usr/bin/caddy /usr/local/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh

ENV HASURA_GRAPHQL_ENABLE_CONSOLE=false

ENV HASURA_GRAPHQL_DEV_MODE=false

# Heroku only allows to install extensions in the heroku_ext schema
ENV HASURA_GRAPHQL_METADATA_DATABASE_EXTENSIONS_SCHEMA=public

# Heroku hobby tier PG has few limitations including 20 max connections
# https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier
ENV HASURA_GRAPHQL_PG_CONNECTIONS=15

CMD ["/bin/bash", "/start.sh"]
