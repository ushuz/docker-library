
grpcc: VERSION ?= 1.1.3
grpcc:
	docker build grpcc/ --build-arg GRPCC_VERSION=$(VERSION) -t ushuz/grpcc:$(VERSION) -t ushuz/grpcc:latest

mycli: VERSION ?= 1.18.2
mycli:
	docker build mycli/ --build-arg MYCLI_VERSION=$(VERSION) -t ushuz/mycli:$(VERSION) -t ushuz/mycli:latest

.PHONY: grpcc mycli
