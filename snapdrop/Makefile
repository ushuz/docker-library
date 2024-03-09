
build-ui:
	docker builder use multiarch
	docker build . -f Dockerfile.ui -t ushuz/snapdrop:ui --platform linux/amd64,linux/arm64 --push
	docker builder use default

build-backend:
	docker builder use multiarch
	docker build . -f Dockerfile.backend -t ushuz/snapdrop:backend --platform linux/amd64,linux/arm64 --push
	docker builder use default

build: build-ui build-backend
