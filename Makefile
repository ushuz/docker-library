
mycli:
	docker build mycli/ -t ushuz/mycli:latest

python-2:
	docker build python/2.7/ -t ushuz/python:2

shadowsocks-libev:
	docker build shadowsocks-libev/ -t ushuz/shadowsocks-libev:latest

spark:
	docker build spark/ -t ushuz/spark:2.0.1

.PHONY: mycli python-2 shadowsocks-libev spark
