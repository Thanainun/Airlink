#!/bin/bash
# Firewall
# Author @Thummawit Somsri For Ubuntu 12.04 airlink IMQ kernel
# Date 1/10/13
#
# 

##################################
#       Firewall Controller	 #
##################################
. /etc/chilli/control.sh
##################################

modprobe ip_nat_ftp
modprobe ip_tables
modprobe iptable_nat
modprobe ipt_conntrack
modprobe ip_conntrack
modprobe ip_conntrack_netlink
modprobe ip_conntrack_ftp
modprobe ip_conntrack_irc
modprobe ip_nat_irc
modprobe ip_nat_snmp_basic
modprobe imq numdevs=2
ifconfig imq0 up
ifconfig imq1 up

DL="imq0"
UL="imq1"



tc qdisc del dev $HS_WANIF root 2>/dev/null
tc qdisc del dev $DL root 2>/dev/null
tc qdisc del dev $UL root 2>/dev/null

if [ $QOS = "QOSCONTROLLON" ]; then

# Download
tc qdisc add dev $DL root handle 1: htb default 1000
tc class add dev $DL parent 1: classid 1:1000 htb rate 10Gbit ceil 10Gbit
tc class add dev $DL classid 1:1001 parent 1:1000 htb prio 1 rate 350Mbit ceil 350Mbit
tc qdisc add dev $DL parent 1:1001 handle 1001: sfq quantum 1514 perturb 10
tc class add dev $DL classid 1:1002 parent 1:1000 htb prio 2 rate 512Kbit ceil 340Mbit
tc qdisc add dev $DL parent 1:1002 handle 1002: sfq quantum 1514 perturb 10
tc class add dev $DL classid 1:1003 parent 1:1000 htb prio 3 rate 256Kbit ceil 330Mbit
tc qdisc add dev $DL parent 1:1003 handle 1003: sfq quantum 1514 perturb 10
tc class add dev $DL classid 1:1004 parent 1:1000 htb prio 4 rate 128Kbit ceil 320Mbit
tc qdisc add dev $DL parent 1:1004 handle 1004: sfq quantum 1514 perturb 10
tc class add dev $DL classid 1:1005 parent 1:1000 htb prio 5 rate 64Kbit ceil 310Mbit
tc qdisc add dev $DL parent 1:1005 handle 1005: sfq quantum 1514 perturb 10
tc class add dev $DL classid 1:1006 parent 1:1000 htb prio 6 rate 32kbit ceil 300Mbit
tc qdisc add dev $DL parent 1:1006 handle 1006: sfq quantum 1514 perturb 10
tc filter add dev $DL protocol ip prio 1 parent 1: handle 1 fw flowid 1:1001
tc filter add dev $DL protocol ip prio 2 parent 1: handle 2 fw flowid 1:1002
tc filter add dev $DL protocol ip prio 3 parent 1: handle 3 fw flowid 1:1003
tc filter add dev $DL protocol ip prio 4 parent 1: handle 4 fw flowid 1:1004
tc filter add dev $DL protocol ip prio 5 parent 1: handle 5 fw flowid 1:1005
tc filter add dev $DL protocol ip prio 6 parent 1: handle 6 fw flowid 1:1006

# Upload
tc qdisc add dev $UL root handle 1: htb default 1000
tc class add dev $UL parent 1: classid 1:1000 htb rate 10Gbit ceil 10Gbit
tc class add dev $UL classid 1:1001 parent 1:1000 htb prio 1 rate 512Kbit ceil 100Mbit
tc qdisc add dev $UL parent 1:1001 handle 1001: sfq quantum 1514 perturb 10
tc class add dev $UL classid 1:1002 parent 1:1000 htb prio 2 rate 256Kbit ceil 256Kbit
tc qdisc add dev $UL parent 1:1002 handle 1002: sfq quantum 1514 perturb 10
tc class add dev $UL classid 1:1003 parent 1:1000 htb prio 3 rate 64Kbit ceil 128Kbit
tc qdisc add dev $UL parent 1:1003 handle 1003: sfq quantum 1514 perturb 10
tc class add dev $UL classid 1:1004 parent 1:1000 htb prio 4 rate 32Kbit ceil 64Kbit
tc qdisc add dev $UL parent 1:1004 handle 1004: sfq quantum 1514 perturb 10
tc class add dev $UL classid 1:1005 parent 1:1000 htb prio 5 rate 16Kbit ceil 32Kbit
tc qdisc add dev $UL parent 1:1005 handle 1005: sfq quantum 1514 perturb 10
tc class add dev $UL classid 1:1006 parent 1:1000 htb prio 6 rate 8Kbit ceil 16Kbit
tc qdisc add dev $UL parent 1:1006 handle 1006: sfq quantum 1514 perturb 10
tc filter add dev $UL protocol ip prio 1 parent 1: handle 1 fw flowid 1:1001
tc filter add dev $UL protocol ip prio 2 parent 1: handle 2 fw flowid 1:1002
tc filter add dev $UL protocol ip prio 3 parent 1: handle 3 fw flowid 1:1003
tc filter add dev $UL protocol ip prio 4 parent 1: handle 4 fw flowid 1:1004
tc filter add dev $UL protocol ip prio 5 parent 1: handle 5 fw flowid 1:1005
tc filter add dev $UL protocol ip prio 6 parent 1: handle 6 fw flowid 1:1006

$IPTABLES -t mangle -N DQOS_P2P
$IPTABLES -t mangle -A DQOS_P2P -j MARK --set-mark 5

 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "BitTorrent" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "BitTorrent protocol" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "peer_id=" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string ".torrent" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "announce.php?passkey=" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "torrent" -j DQOS_P2P
 $IPTABLES -t mangle -A PREROUTING -m string --algo bm --string "info_hash" -j DQOS_P2P


$IPTABLES -t mangle -N UQOS_P2P
$IPTABLES -t mangle -A UQOS_P2P -j MARK --set-mark 6

 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "BitTorrent" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "BitTorrent protocol" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "peer_id=" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string ".torrent" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "announce.php?passkey=" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "torrent" -j UQOS_P2P
 $IPTABLES -t mangle -A POSTROUTING -m string --algo bm --string "info_hash" -j UQOS_P2P


$IPTABLES -t mangle -A $RULE -p icmp -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --dport 1024:65535 -i $HS_WANIF -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --sport 1024:65535 -i $HS_WANIF -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --dport 3128 -i $HS_WANIF -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --sport 3128 -i $HS_WANIF -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --dport 3990 -i $HS_WANIF -j MARK --set-mark 1
$IPTABLES -t mangle -A $RULE -m tcp -p tcp --sport 3990 -i $HS_WANIF -j MARK --set-mark 1

$IPTABLES -t mangle -A $RULE -p tcp -m tcp --tcp-flags SYN,ACK,RST ACK -j MARK --set-mark 2
$IPTABLES -t mangle -A $RULE -p tcp -m tcp --tcp-flags SYN,ACK,RST SYN -j MARK --set-mark 2
$IPTABLES -t mangle -A $RULE -p tcp -m tcp --tcp-flags SYN,ACK,RST SYN,ACK -j MARK --set-mark 2
$IPTABLES -t mangle -A $RULE -p tcp -m tcp --tcp-flags SYN,ACK,RST RST,ACK -j MARK --set-mark 2
$IPTABLES -t mangle -A $RULE -p tcp -m tcp --tcp-flags SYN,ACK,RST FIN,ACK -j MARK --set-mark 2
 
 
fi

# sync
$IPTABLES -A INPUT -i $TUNTAP -p tcp ! --syn -m state --state NEW  -m limit --limit 5/m --limit-burst 7 -j RETURN 
$IPTABLES -A INPUT -i $TUNTAP -p tcp ! --syn -m state --state NEW -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp ! --syn -m state --state NEW  -m limit --limit 5/m --limit-burst 7 -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -p tcp ! --syn -m state --state NEW -j DROP > /dev/null

# Fragments
$IPTABLES -A INPUT -i $TUNTAP -f  -m limit --limit 5/m --limit-burst 7 -j RETURN
$IPTABLES -A INPUT -i $TUNTAP -f -j DROP
$IPTABLES -D INPUT -i $TUNTAP -f  -m limit --limit 5/m --limit-burst 7 -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -f -j DROP > /dev/null

# block bad stuff
$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags ALL FIN,URG,PSH -j RETURN
$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags ALL ALL -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags ALL FIN,URG,PSH -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags ALL ALL -j DROP > /dev/null

$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags ALL NONE -m limit --limit 5/m --limit-burst 7 -j RETURN
$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags ALL NONE -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags ALL NONE -m limit --limit 5/m --limit-burst 7 -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags ALL NONE -j DROP > /dev/null

$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags SYN,RST SYN,RST -j DROP > /dev/null

$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags SYN,FIN SYN,FIN -m limit --limit 5/m --limit-burst 7 -j RETURN
$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags SYN,FIN SYN,FIN -m limit --limit 5/m --limit-burst 7 -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP > /dev/null

$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags FIN,ACK FIN -m limit --limit 5/m --limit-burst 7 -j RETURN
$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags FIN,ACK FIN -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags FIN,ACK FIN -m limit --limit 5/m --limit-burst 7 -j RETURN > /dev/null
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags FIN,ACK FIN -j DROP > /dev/null

$IPTABLES -A INPUT -i $TUNTAP -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
$IPTABLES -D INPUT -i $TUNTAP -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP > /dev/null

$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A INPUT -m state --state INVALID -j DROP
$IPTABLES -A OUTPUT -m state --state INVALID -j DROP
$IPTABLES -A FORWARD -m state --state INVALID -j DROP
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -t nat -A POSTROUTING -s $HS_NETWORK/$HS_NETMASK -o $HS_WANIF -j MASQUERADE

$IPTABLES -A INPUT -p tcp --dport 22 -m state --state NEW -j LOG --log-prefix "[SSH] "
$IPTABLES -A INPUT -p tcp --dport 21:22 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 25 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 80 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 443 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 143 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 993 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 995 -j ACCEPT
$IPTABLES -A INPUT -p udp --dport 53 -j ACCEPT
$IPTABLES -A INPUT -p udp --dport 123 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 3128 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport $UAMPORT -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 1812:1813 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 10000 -j ACCEPT

$IPTABLES -A INPUT -i $TUNTAP -p tcp --dport 110 -j ACCEPT
$IPTABLES -A INPUT -i $TUNTAP -p tcp --dport 143 -j ACCEPT
$IPTABLES -A INPUT -i $TUNTAP -p tcp --dport 149 -j ACCEPT
$IPTABLES -A INPUT -i $TUNTAP -p tcp --dport 445 -j ACCEPT
$IPTABLES -A INPUT -i $TUNTAP -p udp --dport 137:138 -j ACCEPT
$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset
$IPTABLES -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable

if [ $SQUID = "SQUIDON" ]; then

$IPTABLES -t mangle -A PREROUTING -i $TUNTAP -p tcp -m tcp --dport 3128 --syn -j DROP
$IPTABLES -t nat -A PREROUTING -i $TUNTAP -p tcp -m tcp -d $HS_NETWORK/$HS_NETMASK --dport 80 -j RETURN
$IPTABLES -t nat -A PREROUTING -i $TUNTAP -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 3128

#$IPTABLES -t nat -I PREROUTING -d 203.146.170.203 -j SQUID_BYPASS
#$IPTABLES -t nat -I PREROUTING -d 203.146.170.54 -j SQUID_BYPASS
#$IPTABLES -t nat -I PREROUTING -d 203.151.21.62 -j SQUID_BYPASS
#$IPTABLES -t nat -I PREROUTING -d 108.162.196.248 -j SQUID_BYPASS

fi

# Algo string
if [ $BIT = "BITDROP" ]; then

 $IPTABLES -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string ".torrent" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "torrent" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "info_hash" -j DROP
 $IPTABLES -A FORWARD -m string --algo bm --string "/default.ida?" -j DROP  #codered virus
 $IPTABLES -A FORWARD -m string --algo bm --string ".exe?/c+dir" -j DROP  #nimda virus
 $IPTABLES -A FORWARD -m string --algo bm --string ".exe?/c_tftp" -j DROP  #nimda virus
# bittorrent key
 $IPTABLES -A FORWARD -m string --string "peer_id" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "BitTorrent" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "BitTorrent protocol" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "bittorrent-announce" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "announce.php?passkey=" --algo kmp --to 65535 -j DROP
# DHT keyword
 $IPTABLES -A FORWARD -m string --string "info_hash" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "get_peers" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "announce" --algo kmp --to 65535 -j DROP
 $IPTABLES -A FORWARD -m string --string "announce_peers" --algo kmp --to 65535 -j DROP

# DHT INPUT
$IPTABLES -A INPUT -s 0.0.0.0/0 -m string --string "torrent" --algo bm -j DROP
$IPTABLES -A INPUT -s 0.0.0.0/0 -m string --string "announce" --algo bm -j DROP
$IPTABLES -A INPUT -s 0.0.0.0/0 -m string --string "info_hash" --algo bm -j DROP

fi


# Drop package wrom Virus Input, Output 
$IPTABLES -A INPUT -p tcp --dport 135 -j DROP
$IPTABLES -A INPUT -p udp --dport 135 -j DROP
$IPTABLES -A INPUT -p tcp --dport 445 -j DROP
$IPTABLES -A INPUT -p udp --dport 445 -j DROP
$IPTABLES -A INPUT -p tcp --dport 4444 -j DROP
$IPTABLES -A INPUT -p udp --dport 4444 -j DROP
$IPTABLES -A INPUT -p tcp --dport 5554 -j DROP
$IPTABLES -A INPUT -p udp --dport 5554 -j DROP
$IPTABLES -A INPUT -p tcp --dport 9996 -j DROP
$IPTABLES -A INPUT -p udp --dport 9996 -j DROP
$IPTABLES -A INPUT -p tcp --dport 137 -j DROP
$IPTABLES -A INPUT -p udp --dport 137 -j DROP
$IPTABLES -A INPUT -p tcp --dport 138 -j DROP
$IPTABLES -A INPUT -p udp --dport 138 -j DROP
$IPTABLES -A INPUT -p tcp --dport 139 -j DROP
$IPTABLES -A INPUT -p udp --dport 139 -j DROP

$IPTABLES -A OUTPUT -p tcp --dport 135 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 135 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 445 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 445 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 4444 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 4444 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 5554 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 5554 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 9996 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 9996 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 137 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 137 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 138 -j DROP
$IPTABLES -A OUTPUT -p udp --dport 138 -j DROP
$IPTABLES -A OUTPUT -p tcp --dport 139 -j DROP
# ----- DROP -------------

# ----- Block  คนแอบมาใช้ Proxy  จากขา WAN  ---- #
$IPTABLES -A INPUT -i $HS_WANIF -p tcp --dport 3128 -j DROP

# --- IMQ Device
$IPTABLES -t mangle -A PREROUTING -i $HS_WANIF -j IMQ --todev 0
$IPTABLES -t mangle -A POSTROUTING -o $HS_WANIF -j IMQ --todev 1


echo " --------------------------- "
echo " | FIREWALL START COMPLETE | "
echo " --------------------------- "

