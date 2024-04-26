# apollo-federation-compatibility-demo

## Steps to run the demo

1. Create an API key on Cosmo.
2. Let's set up the graphs on Cosmo by running the command `make setup-cosmo COSMO_API_KEY=<api-key>` .
3. Populate the Cosmo API key and the webhook secret as environment variables in the Webhook-app folder.
4. Start the webhook server by running the command make run-webhook-app from the root.
5. Set up the webhook alert on Cosmo, by providing the endpoint, and the secret and then select the FEDERATED_GRAPH_SCHEMA_UPDATED event with the above-created graph.
6. Now, let's make a small change in one of the subgraphs and publish that subgraph.
7. On publish, the webhook would be triggered and the supergraph schema from Apollo would be generated.
8. Start the subgraphs by running the command `make run-subgraphs`.
9. Now we can run the Apollo Gateway using the command `make run-apollo-gateway` or run the   Apollo Router using the command `make run-apollo-router`.