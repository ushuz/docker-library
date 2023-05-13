
grpcc: VERSION ?= 1.1.3
grpcc:
	docker build grpcc/ --build-arg GRPCC_VERSION=$(VERSION) -t ushuz/grpcc:$(VERSION) -t ushuz/grpcc:latest

halbot: VERSION ?= 1989.6.38
halbot:
	docker builder use multiarch
	docker build skynet/ --build-arg VERSION=$(VERSION) -t ushuz/halbot:$(VERSION) -t ushuz/halbot:latest --platform linux/amd64,linux/arm64 --push
	docker builder use default

mastodon: VERSION ?= 3.5.3
mastodon:
	docker buildx build mastodon/ --build-arg MASTODON_VERSION=$(VERSION) -t ushuz/mastodon:$(VERSION) --platform linux/amd64,linux/arm64 --push

mycli: VERSION ?= 1.18.2
mycli:
	docker build mycli/ --build-arg MYCLI_VERSION=$(VERSION) -t ushuz/mycli:$(VERSION) -t ushuz/mycli:latest

.PHONY: grpcc mastodon mycli
