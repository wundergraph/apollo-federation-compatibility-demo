#!/bin/sh

npx concurrently --kill-others \
    "cd subgraphs/inventory && npm run start" \
    "cd subgraphs/pandas && npm run start" \
    "cd subgraphs/products && npm run start" \
    "cd subgraphs/users && npm run start"
