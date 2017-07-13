#!/bin/bash
#service monitoring
#_____author=linuxautobot______
. /lib/lsb/init-functions
MYADMIN="/usr/bin/mysqladmin --defaults-file=/etc/mysql/debian.cnf"
mysql_get_param() {
        /usr/sbin/mysqld --print-defaults \
                | tr " " "\n" \
                | grep -- "--$1" \
                | tail -n 1 \
                | cut -d= -f2
}

mysql_status () {
    ping_output=`$MYADMIN ping 2>&1`; ping_alive=$(( ! $? ))

    ps_alive=0
    pidfile=`mysql_get_param pid-file`
    if [ -f "$pidfile" ] && ps `cat $pidfile` >/dev/null 2>&1; then ps_alive=1; fi

    if [ "$1" = "check_alive"  -a  $ping_alive = 1 ] ||
       [ "$1" = "check_dead"   -a  $ping_alive = 0  -a  $ps_alive = 0 ]; then
        return 0 # EXIT_SUCCESS
    else
        if [ "$2" = "warn" ]; then
            echo -e "$ps_alive processes alive and '$MYADMIN ping' resulted in\n$ping_output\n" | $ERR_LOGGER -p daemon.debug
        fi
        return 1 # EXIT_FAILURE
    fi
}

Mystatus() {
	if mysql_status check_alive nowarn; then
           echo "mysql service is up " > /dev/null
	else
         # log_action_msg "MySQL is stopped."
	   echo "mysql service down" | mail -s "mysql Service DOWN and restarted now" linuxautobot@gmail.com
 	  /etc/init.d/apache2 restart > /dev/null 2>/dev/null
 	  echo 3 > /proc/sys/vm/drop_caches
    /etc/init.d/mysql start > /dev/null 2>/dev/null
	  exit 0
 fi
}

Mystatus

 /bin/netstat -tulpn | awk '{print $4}' |  grep 80 > /dev/null   2>/dev/null
 a=$(echo $?)
 if test $a -ne 0
 then
 echo "http service down" | mail -s "HTTP Service DOWN and restarted now" sanjay.thakur@credr.com
 /etc/init.d/apache2 start > /dev/null 2>/dev/null
 else
 sleep 0
 fi
