#!/bin/bash
#set -x
#read_username(){
#    # read function
#    # if user made blank enter then ask again
#    while [[ -z "${username}" ]]
#	do
#	  command read -p "${1}"
#	done
#    echo "${username}"
#}

filename="sonjaysingh"
_copy(){
until [ $filename == 0  ]
do
  	read -p " enter filename to copy or type 0 to exit : " filename
	if [ $filename == "0" ] ; then
                chown -R $username:$username /home/$username/.ssh
	return 0
        fi
	cp -v /home/server/.keys/$filename /home/$username/.ssh/
done
}

if [ $(id -u) -eq 0 ]; then
	#	read_username
		read -p "Enter username : " username
		egrep "^$username" /etc/passwd >/dev/null

if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1

else
	 useradd -m -d /home/$username $username
	 [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	 echo "$username:easy123" | chpasswd
	 echo -e "\x1b[31m password is set easy123"
	 chage -d 0 $username
	 mkdir -p /home/$username/.ssh
	 echo -e "\x1b[32;40m keys list \nAnalytics-BI.pem  AssignmentServerKey.pem \nbetaTestingInstanceKey.pem CredrDeveloperInstanceKey.pem  \ncredrimageprocesskey.pem credrjenkinskey.pem \nCredrMobileInstanceKey.pem credrnagioskey.pem \ncredrproddbinstancekey.pem credrStagingKey.pem  \ncredrTestke1y.pem DW.pem EverestKey.pem wordpressserverkey.pem \x1b[m"
	 _copy
fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
