#!/bin/bash
exec 1>/dev/null
exec 2>>/root/Carnofluxe/scripts_results/errors.log

tar -cvz -f /var/backups/www/supervision-$(date +%Y%m%d).tar.gz /var/www/
tar -cvz -f /mnt/www/supervision-$(date +%Y%m%d).tar.gz /var/www/

cd /var/backups/www
if [ $(ls | wc -l) -gt 7 ]; then
ls -r1 /var/backups/www | tail +$((7+1)) | xargs rm
fi

cd /mnt/www
if [ $(ls | wc -l) -gt 7 ]; then
ls -r1 /mnt/www | tail +$((7+1)) | xargs rm
fi