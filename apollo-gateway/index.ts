import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { ApolloGateway } from "@apollo/gateway";
import { readFile } from "fs/promises";

let supergraphUpdate;
const gateway = new ApolloGateway({
  async supergraphSdl({ update }) {
    // `update` is a function that we'll save for later use
    supergraphUpdate = update;
    return {
      supergraphSdl: await readFile("./supergraph.graphql", "utf-8"),
    };
  },
});

// Pass the ApolloGateway to the ApolloServer constructor
const server = new ApolloServer({
  gateway,
});

const { url } = await startStandaloneServer(server);
console.log(`🚀  Server ready at ${url}`);
