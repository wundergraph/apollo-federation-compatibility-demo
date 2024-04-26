#!/bin/bash
set -e

docker run -p 3002:3002 \
  --mount "type=bind,source=./apollo-router/supergraph.graphql,target=/dist/apollo-router/supergraph.graphql" \
  --mount "type=bind,source=./apollo-router/config.yaml,target=/dist/apollo-router/config.yaml" \
  --rm \
  ghcr.io/apollographql/router:v1.45.0 --dev -s apollo-router/supergraph.graphql -c apollo-router/config.yaml
