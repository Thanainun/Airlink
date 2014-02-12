#!/bin/bash

OUTPUT_CONFIG_FILE=/etc/squid3/squid.conf

LAN_IP_ADDRESS=`sed '/^\#/d' config.ini | grep -i LAN_IP_ADDRESS | tail -n 1 | sed 's/^.*=//;s/^[[:space:]]*//;s/[[:space:]]*$//'`
LAN_DNS1=`sed '/^\#/d' config.ini | grep -i LAN_DNS1 | tail -n 1 | sed 's/^.*=//;s/^[[:space:]]*//;s/[[:space:]]*$//'`
LAN_DNS2=`sed '/^\#/d' config.ini | grep -i LAN_DNS2 | tail -n 1 | sed 's/^.*=//;s/^[[:space:]]*//;s/[[:space:]]*$//'`
SQUID_CACHE_SIZE=`sed '/^\#/d' config.ini | grep -i SQUID_CACHE_SIZE | tail -n 1 | sed 's/^.*=//;s/^[[:space:]]*//;s/[[:space:]]*$//'`
SQUID_CACHE_PATH=`sed '/^\#/d' config.ini | grep -i SQUID_CACHE_PATH | tail -n 1 | sed 's/^.*=//;s/^[[:space:]]*//;s/[[:space:]]*$//'`

mkdir -p $SQUID_CACHE_PATH > /dev/null 2>&1
chown proxy.proxy $SQUID_CACHE_PATH

cat << EOF > $OUTPUT_CONFIG_FILE
# This file is auto generate by SmartCafe Z script

http_port ${LAN_IP_ADDRESS}:3128 transparent
tcp_outgoing_address 0.0.0.0
udp_incoming_address 0.0.0.0
udp_outgoing_address 0.0.0.0
icp_port 0

# Time Out
request_timeout 5 minutes
forward_timeout 5 minutes
connect_timeout 5 minutes
peer_connect_timeout 1 minutes
pconn_timeout 120 seconds
read_timeout 15 minutes
request_timeout 5 minutes
persistent_request_timeout 2 minute
shutdown_lifetime 5 seconds
negative_ttl 2 minutes
negative_ttl 3 minutes
positive_dns_ttl 120 seconds
negative_dns_ttl 120 seconds

netdb_low 900
netdb_high 1000
client_db on
client_lifetime 1 day

# ACL CONTROLS
#----------------------------------------
acl Manager proto cache_object
acl localhost src 127.0.0.1/32
acl our_networks src 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16
acl All_Port port 1-65535
acl CONNECT method CONNECT
acl blockweb dst 208.73.212.0/24

# mark for no cache
hierarchy_stoplist cgi-bin ? localhost .asp .aspx .php .inf .dll .Xt .xtp .ini localhost php$ inf$ dll$ Xt$ xtp$ ini$ asp$ aspx$ .exe .cfg ucg
acl QUERY urlpath_regex cgi-bin \? localhost .asp .aspx .php .inf .dll .Xt .xtp .ini localhost php$ inf$ dll$ Xt$ xtp$ ini$ asp$ aspx$ updatelist$ patch_S4 .cfg .exe ucg
cache deny QUERY

refresh_pattern ^http://(.*?)/video/(.*?)/(.*?)/(.*?)/(.*?)/(.*?)/* 1440 100% 1440 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://(.*?)/get_video\? 1440 100% 1440 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://(.*?)/videodownload\? 1440 100% 1440 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://update.cabal.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://download.cabal.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patch.sf.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://202.43.34.110/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://202.43.35.101/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://cbt.patch.easportsfifaonline2.in.th/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patch.kr.in.th/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://autopatch.sdo.in.th/patch/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://update.hitsplay.com/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://61.47.57.9/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://www.titanonline.in.th/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patchxshot.winner.co.th/xshotupdate/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patchseal.winner.co.th/Real/.* 10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://auto-at.asiasoft.co.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://ptr.ds.vplay.in.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://202.43.36.37/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://dl.heroesofnewerth.com/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patch.pucca.in.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patch1.raycity.in.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://auto-rm.asiasoft.co.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private
refresh_pattern ^http://patch.zone4.in.th/.*  10080 100% 10080 ignore-reload override-lastmod reload-into-ims override-expire ignore-no-cache ignore-private

# OPTIONS FOR TUNING THE CACHE
# --------------------------------------

quick_abort_min 0 KB
quick_abort_max 0 KB
quick_abort_pct 100

half_closed_clients off

http_access deny blockweb
http_access allow Manager all
http_access deny Manager
http_access allow All_Port
http_access allow CONNECT All_Port
http_access allow localhost
http_access allow our_networks
http_access deny all

http_reply_access allow all
icp_access allow all

# OPTIONS WHICH AFFECT THE CACHE SIZE
# -----------------------------------

cache_mem 1024 MB
cache_swap_low 98
cache_swap_high 99
memory_pools on
memory_pools_limit 414 MB

maximum_object_size 256 MB
maximum_object_size_in_memory 1024 KB

ipcache_size 4096
ipcache_low 98
ipcache_high 99
fqdncache_size 4096

cache_replacement_policy heap LFUDA
memory_replacement_policy heap GDSF

# LOGFILE
# -------------------------------------

#cache_dir aufs $SQUID_CACHE_PATH $SQUID_CACHE_SIZE 24 256
cache_dir diskd $SQUID_CACHE_PATH $SQUID_CACHE_SIZE 16 256 Q1=72 Q2=64

logformat common %{%Y-%m-%d %H:%M:%S}tl %6tr %>a %Ss/%03<Hs %<st %rm %ru %un %Sh/%<A %mt
cache_access_log  /var/log/squid3/common.log common
cache_access_log  /var/log/squid3/access.log
cache_log /var/log/squid3/cache.log
cache_store_log none
pid_filename /var/run/squid3.pid

log_fqdn off
client_netmask 255.255.255.255
ftp_passive on
ftp_sanitycheck on
dns_nameservers 127.0.0.1 $LAN_DNS1 $LAN_DNS2

# ADMINISTRATIVE PARAMETERS
# ------------------------------

cache_mgr squid@localhost
visible_hostname cache.hadyaiinternet.com

# MISCELLANEOUS
# -------------------------------
log_icp_queries off
query_icmp off
buffered_logs off
reload_into_ims on
nonhierarchical_direct off
prefer_direct on
strip_query_terms off
pipeline_prefetch on
ie_refresh on
forwarded_for on
vary_ignore_expire on
store_dir_select_algorithm round-robin
ignore_unknown_nameservers on

#============================================================#
# SNMP
#============================================================#
acl snmpcommunity snmp_community public
snmp_port 3401
snmp_access allow snmpcommunity localhost
snmp_access deny all

EOF

echo "Make /etc/squid3/squid.conf      ..done."

