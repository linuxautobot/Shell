#!/bin/bash
cron=/etc/cron.allow
log=/tmp/hardening.log
echo -e " ---------------- \/ \n  " >> $log
echo -e  "writen by SONLIN"         >> $log 
echo -e " ---------------- /\ \n "  >> $log
echo -e "RUN ROOT ONLY /n WARNING PLEASE RUNING THIS SCRIPT ONCES OR ELSE REVERT CHANGES MADE BY SCRIPT MAINLY KERNEL PARAMETER"
date >> $log
hostname >> $log 
hostname -I >> $log
uptime >> $log 
if [ -f $cron ];
then
echo "root" >> $cron
else 
touch $cron
echo "root" >> $cron
fi
useradd admin 2>>$log
#please enter the password to the selected user
echo "PASSWORD" | passwd --stdin admin 2>>$log
echo "user admin is create with password " >> $log
cp -r  ~/ubuntu/.ssh ~/admin/.ssh 2>>$log 
chmod -R 700 ~/admin/.ssh
chown -R admin.admin ~/admin/.ssh
#copy two file will be copied known_host and authorized_keys  
##Warning 
#disable ubuntu user manually after testing the admin user 
if  dpkg --get-selections | grep -i sudo ;   then
echo " package already installed " 
#echo " admin ALL=(ALL) ALL " >> /etc/sudoers 
#usermod -a -G sudo admin 
else
echo "install pkg"
fi
echo '---------------------' >> $log
echo -e "number of pakages installed" >> $log
dpkg -l | wc -l  >> $log
echo '---------------------' >> $log
cat > /root/banner << EOF
|-----------------------------------------------------------------|
| This system is for the use of authorized users only. |
| Individuals using this computer system without authority, or in |
| excess of their authority, are subject to having all of their |
| activities on this system monitored and recorded by system |
| personnel. |
| |
| In the course of monitoring individuals improperly using this |
| system, or in the course of system maintenance, the activities |
| of authorized users may also be monitored. |
| |
| Anyone using this system expressly consents to such monitoring |
| and is advised that if such monitoring reveals possible |
| evidence of criminal activity, system personnel may provide the |
| evidence of such monitoring to law enforcement officials. |
|-----------------------------------------------------------------|
EOF
#parameter may vary from version to the os make sure you check before you run
sed -i 's/PermitRootLogin without-password/PermitRootLogin no/g' /etc/ssh/sshd_config
/etc/init.d/sshd reload 
echo -e "please enter the autoremove | autoclean | clean | update  \n autoremove: is used to remove packages that were automatically installed to satisfy dependencies for some package and that are no more needed. \n autoclean: Like clean, autoclean clears out the local repository of retrieved package files. The difference is that it only removes package files that can no longer be downloaded, and are largely useless. This allows a cache to be maintained over a long period without it growing out of control. The configuration option APT::Clean-Installed will prevent installed packages from being erased if it is set to off.  \n  clean: clean clears out the local repository of retrieved package files. It removes everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial/. When APT is used as a dselect(1) method, clean is run automatically. Those who do not use dselect will likely want to run apt-get clean from time to time to free up disk space. "
read -p " Please Enter CMD : " num 
case "$num" in
autoremove)  echo  " atuoremove the packages"
apt-get autoremove 
;;
autoclean)  echo "autoclean the packages"
apt-get autoclean
;;
clean)   echo  "clean "
apt-get clean
;;
update)  echo "update os "
apt-get update
;;
*) echo "please enter autoremove | autoclean | clean " 
esac 
echo '---------------------' >> $log
echo -e '
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1 '  >> /etc/sysctl.conf

sed -i 's/exec shutdown -r now "Control-Alt-Delete pressed"/#exec shutdown -r now "Control-Alt-Delete pressed"/g' /etc/init/control-alt-delete.conf

echo '---------------------' >> $log
sysctl -p  2>>$log 
#echo 'disable ipv6 ' >> $log
echo ' If you see 1, ipv6 has been successfully disabled. ' >> $log
cat /proc/sys/net/ipv6/conf/all/disable_ipv6  >> $log 
if  dpkg --get-selections | grep -i nmap ;   then
echo "namp is already installed"
else  
echo "installing nmap please wait"
apt-get install nmap 
fi
echo "port scanning it may take a while"
namp localhost  >> $log
apt-get remove nmap  2>>$log 
echo '---------------------' >> $log
echo 'investigate sockets ' >>$log
ss >> $log 
echo '---------------------' >> $log
echo 'Printing network connections, routing tables, interface statistics, masquerade connections, and multicast memberships' >> $log
netstat -tulnp  >> $log 
echo '---------------------' >> $log
echo 'Please have Patients while we scan for setgid'
echo -ne '#####                     (33%)\r'
sleep 1
find / -type f -perm /4000 -exec stat -c "%A %a %n" {} \; >> $log
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo '---------------------' >> $log
#echo 'Unowned Files'
#find / -path /proc -prune -o -nouser -o -nogroup  >> $log 
echo "bad logins" >> $log
lastb >>$log
echo '---------------------' >> $log
echo -e ' check the log file $log FTW! '

