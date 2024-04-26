setup-cosmo:
	./scripts/setup-cosmo.sh $(COSMO_API_KEY)

run-apollo-router:
	./scripts/run-apollo-router.sh

run-apollo-gateway:
	cd apollo-gateway && npm i && npm run start

run-webhook-app:
	cd webhook-app && npm i && npm run dev

run-subgraphs:
	./scripts/run-subgraphs.sh