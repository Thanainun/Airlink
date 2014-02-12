#!/bin/sh
timeaccess=`date +%Y%m%d`
#############################################################
############ Save Squid Log #################################
find /data/LOG/squid/ -type f -mtime +120 | xargs rm -f   #### -mtime = modified time #####
#
cp -Rf /var/log/squid3/access.log /data/LOG/squid/$timeaccess-access.log
chmod 777 /data/LOG/squid/$timeaccess-access.log
gzip /data/LOG/squid/$timeaccess-access.log
md5sum /data/LOG/squid/$timeaccess-access.log.gz > /data/LOG/squid/$timeaccess-access.log.gz.md5sum
############  Save  Radius  Log  #############################
find /data/LOG/radius/ -type f -mtime +120 | xargs rm -f
#
cp -Rf /var/log/freeradius/radacct/127.0.0.1/detail-$timeaccess /data/LOG/radius/$timeaccess-radact
chmod 777 /data/LOG/radius/$timeaccess-radact
gzip /data/LOG/radius/$timeaccess-radact
md5sum /data/LOG/radius/$timeaccess-radact.gz > /data/LOG/radius/$timeaccess-radact.gz.md5sum
############  Save  Secure  Log  ##############################
find /data/LOG/secure/ -type f -mtime +120 | xargs rm -f
#
cp -Rf /var/log/auth.log  /data/LOG/secure/$timeaccess-auth.log
chmod 777 /data/LOG/secure/$timeaccess-auth.log
gzip /data/LOG/secure/$timeaccess-auth.log
md5sum /data/LOG/secure/$timeaccess-auth.log.gz > /data/LOG/secure/$timeaccess-auth.log.gz.md5sum
########### MySQL Database radius ##############################
find /data/LOG/mysql/ -type f -mtime +120 | xargs rm -f
#
mysqldump -u root -pduydui1909 radius voucher | gzip > /data/LOG/mysql/$timeaccess-radius_voucher.sql.gz
md5sum /data/LOG/mysql/$timeaccess-radius_voucher.sql.gz > /data/LOG/mysql/$timeaccess-radius_voucher.sql.gz.md5sum
mysqldump -u root -pduydui1909 radius radacct | gzip > /data/LOG/mysql/$timeaccess-radius_radacct.sql.gz
md5sum /data/LOG/mysql/$timeaccess-radius_radacct.sql.gz > /data/LOG/mysql/$timeaccess-radius_radacct.sql.gz.md5sum
mysqldump -u root -pduydui1909 radius traffic | gzip > /data/LOG/mysql/$timeaccess-radius_traffic.sql.gz
md5sum /data/LOG/mysql/$timeaccess-radius_traffic.sql.gz > /data/LOG/mysql/$timeaccess-radius_traffic.sql.gz.md5sum
################################################################
#####  Save  Fail2ban  Log  ####
find /data/LOG/fail2ban/ -type f -mtime +120 | xargs rm -f
cp -Rf /var/log/fail2ban.log  /data/LOG/fail2ban/$timeaccess-fail2ban.log
chmod 777 /data/LOG/fail2ban/$timeaccess-fail2ban.log
gzip /data/LOG/fail2ban/$timeaccess-fail2ban.log
md5sum /data/LOG/fail2ban/$timeaccess-fail2ban.log.gz > /data/LOG/fail2ban/$timeaccess-fail2ban.log.gz.md5sum
#
#####  Save  apache2  Log  ####
find /data/LOG/apache2/ -type f -mtime +120 | xargs rm -f
cp -Rf /var/log/apache2/access.log  /data/LOG/apache2/$timeaccess-access.log
chmod 777 /data/LOG/apache2/$timeaccess-access.log
gzip /data/LOG/apache2/$timeaccess-access.log
md5sum /data/LOG/apache2/$timeaccess-access.log.gz > /data/LOG/apache2/$timeaccess-access.log.gz.md5sum
#
cp -Rf /var/log/apache2/error.log  /data/LOG/apache2/$timeaccess-error.log
chmod 777 /data/LOG/apache2/$timeaccess-error.log
gzip /data/LOG/apache2/$timeaccess-error.log
md5sum /data/LOG/apache2/$timeaccess-error.log.gz > /data/LOG/apache2/$timeaccess-error.log.gz.md5sum
#
chmod -R 755 /data/LOG/
#
exit 0
