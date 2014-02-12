#!/bin/bash
/etc/init.d/squid3 stop
rm -rf /var/spool/squid3/
mkdir -p /var/spool/squid3
chown proxy:proxy /var/spool/squid3
chmod 777 /var/spool/squid3
squid3 -z
/etc/init.d/squid3 start
exit 0
