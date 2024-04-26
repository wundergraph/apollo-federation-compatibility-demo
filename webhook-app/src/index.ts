import { serve } from "@hono/node-server";
import { Hono } from "hono";
import crypto from "crypto";
import { exec } from "child_process";
import dotenv from "dotenv";

const app = new Hono();

dotenv.config();

function verifySignature(
  body: string,
  receivedSignature: string,
  secret: string
) {
  const computedSignature = crypto
    .createHmac("sha256", secret)
    .update(body)
    .digest("hex");

  return computedSignature === receivedSignature;
}

app.get("/", (c) => {
  return c.text("Hello Hono!");
});

app.post("/webhook", async (c) => {
  const cosmoSignature = c.req.header("x-cosmo-signature-256");
  const body = await c.req.json();

  const isVerified = verifySignature(
    JSON.stringify(body),
    cosmoSignature!,
    process.env.WEBHOOK_SECRET!
  );

  if (!isVerified) {
    return c.text("Invalid signature", 401);
  }

  if (body.event === "FEDERATED_GRAPH_SCHEMA_UPDATED" && !body.payload.errors) {
    const fedGraphName = body.payload.federated_graph.name;
    const fedGraphNamespace = body.payload.federated_graph.namespace;

    exec(
      `sh ../scripts/fetch-graph.sh ${fedGraphName} ${fedGraphNamespace} ${process.env.COSMO_API_KEY}`,
      (error: any, stdout: any, stderr: any) => {
        console.log(stdout);
        console.log(stderr);
        if (error !== null) {
          console.log(`exec error: ${error}`);
          return c.text(`Error: ${error}`, 500);
        }
      }
    );
  }
  console.log("Updated the graph successfully");
  return c.text("Updated the graph successfully", 200);
});

const port = 3003;
console.log(`Server is running on port ${port}`);

serve({
  fetch: app.fetch,
  port,
});
