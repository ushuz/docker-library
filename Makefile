
grpcc:
	docker build grpcc/ -t ushuz/grpcc:latest

mycli:
	docker build mycli/ -t ushuz/mycli:latest

shadowsocks-libev:
	docker build shadowsocks-libev/ -t ushuz/shadowsocks-libev:latest

.PHONY: mycli python-2 shadowsocks-libev
