#!/bin/bash
set -e

npm install -g wgc@latest

export COSMO_API_KEY=$3

wgc federated-graph fetch $1 --namespace $2 --apollo-compatibility -o ../

cd ../$1-$2/scripts/

chmod +x ./apollo.sh

sh ./apollo.sh

cd ../supergraph/

cp apolloSchema.graphql ../../apollo-gateway/supergraph.graphql
cp apolloSchema.graphql ../../apollo-router/supergraph.graphql