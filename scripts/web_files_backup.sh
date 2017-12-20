tar -cvz -f /var/backups/www/supervision-$(date +%Y%m%d).tar.gz /var/www/
cd /var/backups/www
ls -r1 /var/backups/www | tail +$((7+1)) | xargs rm
