#!/bin/sh

#------------------------------------------------------------------------------
# Configure the service:
#------------------------------------------------------------------------------
env echo server.py -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOL_PARAM -g $OBFS_PARAM

env python /~/shadowsocksr-manyuser/shadowsocks/server.py -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS_PARAM -G $PROTOCOL_PARAM -g $OBFS_PARAM
env /usr/sbin/privoxy --no-daemon /etc/privoxy/config
