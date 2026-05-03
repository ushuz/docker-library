
halbot: VERSION ?= 1989.6.38
halbot:
	docker build skynet/ --builder multiarch --build-arg VERSION=$(VERSION) -t ushuz/halbot:$(VERSION) -t ushuz/halbot:latest --platform linux/amd64,linux/arm64 --push

snapdrop-ui:
	docker build snapdrop/ --builder multiarch -f snapdrop/Dockerfile.ui -t ushuz/snapdrop:ui --platform linux/amd64,linux/arm64 --push

snapdrop-backend:
	docker build snapdrop/ --builder multiarch -f snapdrop/Dockerfile.backend -t ushuz/snapdrop:backend --platform linux/amd64,linux/arm64 --push

snapdrop: snapdrop-ui snapdrop-backend

.PHONY: halbot snapdrop snapdrop-ui snapdrop-backend
