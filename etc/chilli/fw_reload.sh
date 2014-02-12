#!/bin/bash
# 

IPTABLES="/usr/local/sbin/iptables"

HS_WANIF=eth0
TUNTAP=tun0

HS_NETWORK=10.0.0.0
HS_NETMASK=255.255.252.0
UAMPORT=3990 

$IPTABLES -F
$IPTABLES -X
$IPTABLES -t nat -F
$IPTABLES -t nat -X
$IPTABLES -t filter -F
$IPTABLES -t filter -X
$IPTABLES -t mangle -F
$IPTABLES -t mangle -X
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT ACCEPT

. /etc/chilli/firewall.sh

