#!/bin/bash
set -e

# npm install -g wgc@latest

cd '/Users/jivus/Documents/VS Code/cosmo/cli'
export COSMO_API_KEY=$3
export COSMO_API_URL=http://localhost:3001
export KC_API_URL=http://localhost:8080
export CDN_URL=http://localhost:11000

pnpm wgc federated-graph fetch $1 --namespace $2 --apollo-compatibility -o '../../apollo-federation-compatibility-demo'

cd /Users/jivus/Documents/VS\ Code/apollo-federation-compatibility-demo/$1-$2/scripts/

chmod +x ./apollo.sh

sh ./apollo.sh

cd ../supergraph/

cp apolloSchema.graphql /Users/jivus/Documents/VS\ Code/apollo-federation-compatibility-demo/apollo-gateway/supergraph.graphql
cp apolloSchema.graphql /Users/jivus/Documents/VS\ Code/apollo-federation-compatibility-demo/apollo-router/supergraph.graphql