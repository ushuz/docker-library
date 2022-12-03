
grpcc: VERSION ?= 1.1.3
grpcc:
	docker build grpcc/ --build-arg GRPCC_VERSION=$(VERSION) -t ushuz/grpcc:$(VERSION) -t ushuz/grpcc:latest

mastodon: VERSION ?= 3.5.3
mastodon:
	docker buildx build mastodon/ --build-arg MASTODON_VERSION=$(VERSION) -t ushuz/mastodon:$(VERSION) --platform linux/amd64,linux/arm64 --push

mycli: VERSION ?= 1.18.2
mycli:
	docker build mycli/ --build-arg MYCLI_VERSION=$(VERSION) -t ushuz/mycli:$(VERSION) -t ushuz/mycli:latest

.PHONY: grpcc mastodon mycli
