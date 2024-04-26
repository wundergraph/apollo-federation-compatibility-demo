#!/bin/sh

npx concurrently --kill-others \
    "cd subgraphs/inventory && npm i && npm run start" \
    "cd subgraphs/pandas && npm i && npm run start" \
    "cd subgraphs/products && npm i && npm run start" \
    "cd subgraphs/users && npm i && npm run start"
