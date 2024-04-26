#!/bin/bash
set -e

# Create and publish a demo federated graph based on the subgraphs in the subgraphs folder

# npm install -g wgc@latest

cd '/Users/jivus/Documents/VS Code/cosmo/cli'
export COSMO_API_KEY=cosmo_669b576aaadc10ee1ae81d9193425705
export COSMO_API_URL=http://localhost:3001
export KC_API_URL=http://localhost:8080
export CDN_URL=http://localhost:11000

wgc federated-graph create mygraph --namespace default --label-matcher team=A,team=B --routing-url http://localhost:3002/graphql

wgc subgraph create inventory --namespace default --label team=A --routing-url http://localhost:4001/graphql
wgc subgraph create pandas --namespace default --label team=A --routing-url http://localhost:4002/graphql
wgc subgraph create products --namespace default --label team=B --routing-url http://localhost:4003/graphql
wgc subgraph create users --namespace default --label team=B --routing-url http://localhost:4004/graphql

SUBGRAPHS="users pandas products inventory"

for subgraph in $SUBGRAPHS; do
  pnpm wgc subgraph publish $subgraph --namespace default --schema /Users/jivus/Documents/VS\ Code/apollo-federation-compatibility-demo/subgraphs/$subgraph/$subgraph.graphql
done
