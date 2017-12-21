#!/bin/bash
exec 1>/dev/null
exec 2>>/root/Carnofluxe/scripts_results/errors.log

tar -cvz -f /var/backups/apache2/apache2-$(date +%Y%m%d).tar.gz /etc/apache2/
tar -cvz -f /mtn/apache2-$(date +%Y%m%d).tar.gz /etc/apache2/