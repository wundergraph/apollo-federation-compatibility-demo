#!/bin/bash
set -e

# Create and publish a demo federated graph based on the subgraphs in the subgraphs folder

npm install -g wgc@latest

export COSMO_API_KEY=$1

wgc federated-graph create mygraph --namespace default --label-matcher team=A,team=B --routing-url http://localhost:3002/graphql

wgc subgraph create inventory --namespace default --label team=A --routing-url http://localhost:4001/graphql
wgc subgraph create pandas --namespace default --label team=A --routing-url http://localhost:4002/graphql
wgc subgraph create products --namespace default --label team=B --routing-url http://localhost:4003/graphql
wgc subgraph create users --namespace default --label team=B --routing-url http://localhost:4004/graphql

SUBGRAPHS="users pandas products inventory"

for subgraph in $SUBGRAPHS; do
  wgc subgraph publish $subgraph --namespace default --schema ./subgraphs/$subgraph/$subgraph.graphql
done
