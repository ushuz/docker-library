
build-ui:
	docker build . --builder multiarch -f Dockerfile.ui -t ushuz/snapdrop:ui --platform linux/amd64,linux/arm64 --push

build-backend:
	docker build . --builder multiarch -f Dockerfile.backend -t ushuz/snapdrop:backend --platform linux/amd64,linux/arm64 --push

build: build-ui build-backend
