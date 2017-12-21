#!/bin/bash

exec 2>>/root/Carnofluxe/scripts_results/errors.log

hostname="HTTP-carnofluxe"

rm /etc/apache2/sites-enabled/*
rm /etc/apache2/sites-available/*
echo "127.0.0.1	$hostname" >> /etc/hosts
echo $hostname > /etc/hostname

printf "
127.0.0.1	www.carnofluxe.local
127.0.0.1	www.carnofluxe.fr
127.0.0.1	supervision.carnofluxe.local
" >> /etc/hosts

printf "
<VirtualHost 192.168.10.10:80>
    ServerName supervision.carnofluxe.local
    DocumentRoot \"/var/www/supervision\"
</VirtualHost>
" > /etc/apache2/sites-available/supervision.carnofluxe.local.conf

printf "
<VirtualHost 192.168.10.10:80>
    ServerName www.carnofluxe.local
    ServerAlias carnofluxe.local
    DocumentRoot \"/var/www/carnofluxe\"
</VirtualHost>
" > /etc/apache2/sites-available/carnofluxe.local.conf

printf "
<VirtualHost 10.50.50.1:80>
    ServerName www.carnofluxe.fr
    ServerAlias carnofluxe.fr
    DocumentRoot \"/var/www/carnofluxe\"
</VirtualHost>
" > /etc/apache2/sites-available/carnofluxe.fr.conf

mkdir /var/www/supervision

mv /root/Carnofluxe/supervision/* /var/www/supervision/

mkdir /var/www/carnofluxe/ && echo "<html>
  <head>
    <title>Bienvenue sur carnofluxe.fr !</title>
  </head>
  <body>
    <h1>Bienvenue sur carnofluxe.fr !</h1>
  </body>
</html>
" >  /var/www/carnofluxe/index.html


ln -s /root/Carnofluxe/scripts_results/last_connexions.csv /var/www/supervision/ip.csv
ln -s /root/Carnofluxe/scripts_results/info.csv /var/www/supervision/data.csv
ln -s /root/Carnofluxe/scripts_results/basic_monitoring.log /var/www/supervision/basic_monitoring.log


a2ensite carnofluxe.fr.conf
a2ensite carnofluxe.local.conf
a2ensite supervision.carnofluxe.local.conf

systemctl restart apache2
systemctl status apache2