
mycli:
	docker build mycli/ -t ushuz/mycli:latest

shadowsocks-libev:
	docker build shadowsocks-libev/ -t ushuz/shadowsocks-libev:latest

spark:
	docker build spark/ -t ushuz/spark:2.0.1

.PHONY: mycli python-2 shadowsocks-libev spark
