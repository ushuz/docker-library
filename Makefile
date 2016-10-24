
python-2:
	docker build python/2.7/ -t ushuz/python:2

mycli:
	docker build mycli/ -t ushuz/mycli:latest

.PHONY: python-2 mycli
