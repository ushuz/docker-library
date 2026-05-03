
halbot: VERSION ?= 1989.6.38
halbot:
	docker build skynet/ --builder multiarch --build-arg VERSION=$(VERSION) -t ushuz/halbot:$(VERSION) -t ushuz/halbot:latest --platform linux/amd64,linux/arm64 --push

.PHONY: halbot
