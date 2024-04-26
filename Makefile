setup-cosmo:
	./scripts/setup-cosmo.sh

run-apollo-router:
	./scripts/run-apollo-router.sh

run-apollo-gateway:
	cd apollo-gateway && npm run start

run-webhook-app:
	cd webhook-app && npm run dev

run-subgraphs:
	./scripts/run-subgraphs.sh