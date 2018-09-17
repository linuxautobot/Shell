 #!/bin/bash
report="/tmp/status_report.txt"
uptime > $report
service=( nginx  mongod  mysql php-fpm  mosquitto )

for a  in "${service[@]}"
	 do
	  if (( $(ps -ef | grep -v grep | grep "$a" | wc -l) > 0 ))
	  then
			echo "$a is running!!!" >> $report
	  else
	    /etc/init.d/$a start
	    echo "$a was stopped  restarting" >> $report
	  fi
done

mail -s "service status" linuxautobot@gmail.com -A $report
