#!/bin/sh

TUNTAP=$(basename $DEV)
UNDO_FILE=/var/run/chilli.$TUNTAP.sh

. /etc/chilli/functions

[ -e "$UNDO_FILE" ] && sh $UNDO_FILE 2>/dev/null
rm -f $UNDO_FILE 2>/dev/null

ipt() {
    opt=$1; shift
    echo "iptables -D $*" >> $UNDO_FILE
    iptables $opt $*
}

ipt_in() {
    ipt -I INPUT -i $TUNTAP $*
}

if [ -n "$TUNTAP" ]
then

	iptables -F
	iptables -X
	iptables -t nat -F
	iptables -t nat -X
	iptables -t filter -F
	iptables -t filter -X
	iptables -t mangle -F
	iptables -t mangle -X
	iptables -P INPUT DROP
	iptables -P OUTPUT ACCEPT

	. /etc/chilli/firewall.sh

fi

# site specific stuff optional
[ -e /etc/chilli/ipup.sh ] && . /etc/chilli/ipup.sh

cat > /etc/chilli/fw_reload.sh <<EOF
#!/bin/bash
# 

IPTABLES="/usr/local/sbin/iptables"

HS_WANIF=$HS_WANIF
TUNTAP=$TUNTAP

HS_NETWORK=$HS_NETWORK
HS_NETMASK=$HS_NETMASK
UAMPORT=$HS_UAMPORT 

\$IPTABLES -F
\$IPTABLES -X
\$IPTABLES -t nat -F
\$IPTABLES -t nat -X
\$IPTABLES -t filter -F
\$IPTABLES -t filter -X
\$IPTABLES -t mangle -F
\$IPTABLES -t mangle -X
\$IPTABLES -P INPUT DROP
\$IPTABLES -P OUTPUT ACCEPT

. /etc/chilli/firewall.sh

EOF

chmod +x /etc/chilli/fw_reload.sh
