#!/bin/bash
exec 1>/dev/null
exec 2>/home/romain/test.log
DATE=`date "+%s"`
DATElasthour=$((DATE - 3600))
dir=/home/romain/last_connexions.csv
dir2=/home/romain/last_connexions2.csv
conf=/etc/apache2/apache2.conf

sed -i 's/%t/%{sec}t/g' $conf 
cut -d '"' -f -1 /var/log/apache2/access.log | sed 's/\[//' | sed 's/- //' | awk '!seen[$0]++' > $dir
touch $dir2
while read -r line
do
    line2=`echo $line | egrep -o '[0-9]**$'`  
	
	if (( $line2 > $DATElasthour )); then		
		echo $line | cut -d ' ' -f -1 >>"$dir2"
	fi
done < $dir
mv $dir2 $dir

touch $dir2
echo 'IP,PAYS' >>"$dir2"
while read -r line
do
	echo -n $line >>"$dir2"
	echo -n ','	>>"$dir2"
	echo -n `curl ipinfo.io/$line | grep country | sed 's/[":,country]//g'` >>"$dir2" 
	echo '' >>"$dir2" 
done < $dir
mv $dir2 $dir

