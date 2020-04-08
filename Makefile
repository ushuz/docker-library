
grpcc:
	docker build grpcc/ -t ushuz/grpcc:latest

mycli:
	docker build mycli/ -t ushuz/mycli:latest

.PHONY: clash grpcc mycli
