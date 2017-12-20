#!/bin/bash
exec 1>/dev/null
exec 2>/root/Carnofluxe/scritps_results/errors.log
dir=~/info.csv
curlconf=~/curloutput.txt

echo "Temps ping serveur http,`ping -c 4 192.168.10.10 | grep rtt | cut -d '/' -f -5 | cut -d '/' -f 5-`" >"$dir"

echo "Etat du DNS,`dig @192.168.10.5 ns1.carnofluxe.local | grep status | cut -d ',' -f -2 | cut -d ',' -f 2- | sed 's/status: //'`" >>"$dir"

if curl 192.168.10.10:80; then
    echo "Disponibilité du site web,Site up" >>"$dir"
        echo '%{time_total}\n' > "$curlconf"
        echo "Temps de reponse du site,`curl -w "@$curlconf" -o /dev/null -s 192.168.10.10`">>"$dir"
        rm "$curlconf"
else
    echo "Disponibilité du site web,Site down" >>"$dir"
        echo 'Temps de reponse du site,null' >>"$dir"
fi

scp $dir debian@192.168.10.10:~/info.csv

