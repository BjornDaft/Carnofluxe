#!/bin/bash

exec 1>/root/Carnofluxe/scripts_results/basic_monitoring.log

echo -e '\n Log file: /root/Carnofluxe/scripts_results/basic_monitoring.log<br>\n'

apache2_status=`systemctl status apache2 | head -n 3`
echo $apache2_status > /root/Carnofluxe/scripts_results/apache2_status
date >> /root/Carnofluxe/scripts_results/apache2_status
head -n 1 /root/Carnofluxe/scripts_results/apache2_status
egrep --color '[A-Z]([a-z]{2})[ ][A-Z]([a-z]{2})[ ]([0-9]{2}).*' /root/Carnofluxe/scripts_results/apache2_status
echo "<br><br>"
echo -e '\n Available disk space (root):<br>'
df -h | egrep '/$'
echo "<br><br>"
#Test if sums file exists
if [ ! -f /var/run/sums_apache ]; then
	find /etc/apache2 -type f | xargs md5sum > /var/run/sums_apache
	echo -e '\nFile /var/run/sums_apache created !'
fi

echo -e '\nModified Apache2 files:<br>'
find /etc/apache2 -type f | xargs md5sum | grep -vf /var/run/sums_apache

find /etc/apache2 -type f | xargs md5sum > /var/run/sums_apache


if [ ! -f /var/run/sums_users ]; then
	cat /etc/passwd >  /var/run/sums_users
fi
echo "<br>"
echo -e "\nNew users: <br>"
cat /etc/passwd | grep -vf /var/run/sums_users | egrep -o '^[a-z]**'

cat /etc/passwd >  /var/run/sums_users

echo "<br><br>"

