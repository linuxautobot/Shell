#killMOFO=$(mysqladmin processlist -u root -pLoans\$#Devops  | awk '$2 ~ /^[0-9]/ {print ""$2";"}')

mofos=$(mysql -e "SELECT ID
FROM   INFORMATION_SCHEMA.PROCESSLIST
WHERE  USER = 'jira_user'
       AND COMMAND = 'sleep'
       AND TIME > 10;"  -u root -pLoans\$#Devops)

for KILL in $mofos
do
mysql -e "kill $KILL;" -u root -pFake\$#passwd
#echo $KILL
done

#mongokill=$(sudo lsof | grep mongod | grep TCP  | awk {'print $2'})
#for a in $mongokill ; do sudo   kill -9 $a ; done
