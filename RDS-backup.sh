#!/bin/sh
FILE=/home/devops/prod/minime.sql.`date +%F%H`
DBSERVER=ap-south-1.rds.amazonaws.com
DATABASE=ws_prod_db
PASS=VpZn7Z
USER=connect


mysqldump  --host=${DBSERVER} --opt --user=${USER} --password=${PASS} ${DATABASE} --ignore-table=flexiloans_aws_prod_db.communication_request_log --ignore-table=flexiloans_aws_prod_db.communication_request  --ignore-table=flexiloans_aws_prod_db.customer_call_log  > ${FILE}
gzip -9 $FILE
aws s3 cp $FILE.gz s3://DevOps/RDS/
#rm  $FILE
find /home/devops/prod/minime.sql*  -mtime +1  -exec rm  {} \;
