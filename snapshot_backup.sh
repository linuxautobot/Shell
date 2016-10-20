#!/bin/bash

# Volume_list volume-id:Volume-name format

VOLUMES_LIST=/var/log/snapshot/volumes-list
SNAPSHOT_INFO=/var/log/snapshot/snapshot_info
DATE=`date +%Y-%m-%d`
REGION="ap-southeast-1"

RETENTION=1

SNAP_CREATION=/var/log/snapshot/snap_creation
SNAP_DELETION=/var/log/snapshot/snap_deletion

EMAIL_LIST=devops@credr.com

echo "List of Snapshots Creation Status" > $SNAP_CREATION
echo "List of Snapshots Deletion Status" > $SNAP_DELETION
                                                                if [ -f $VOLUMES_LIST ]; then


for VOL_INFO in `cat $VOLUMES_LIST`
do
    VOL_ID=`echo $VOL_INFO | awk -F":" '{print $1}'`
    VOL_NAME=`echo $VOL_INFO | awk -F":" '{print $2}'`
        DESCRIPTION="${VOL_NAME} ${DATE} Snaphshot_backup"

                /usr/local/bin/aws ec2 create-snapshot --volume-id $VOL_ID --description "$DESCRIPTION" --region $REGION --output text  >> $SNAP_CREATION && sleep 5
    done
                                                                else
        echo "Volumes list file is not available : $VOLUMES_LIST Exiting." | mail -aFrom:mohit.c@credr.com -s "Snapshots Creation Status" $EMAIL_LIST               exit 1
                                                                fi
                                        echo >> $SNAP_CREATION
                            #           echo >> $SNAP_CREATION

for VOL_INFO in `cat $VOLUMES_LIST`
    do

VOL_ID=`echo $VOL_INFO | awk -F":" '{print $1}'`
VOL_NAME=`echo $VOL_INFO | awk -F":" '{print $2}'`


    /usr/local/bin/aws ec2 describe-snapshots --query Snapshots[*].[SnapshotId,VolumeId,Description,StartTime] --output text --filters "Name=volume-id,Values=$VOL_ID" | grep "Snaphshot_backup" > $SNAPSHOT_INFO
    #/usr/local/bin/aws ec2 describe-snapshots --query Snapshots[*].[SnapshotId,VolumeId,Description,StartTime] --output text --filters "Name=volume-id,Values=$VOL_ID"
                                                echo $VOL_ID
echo ">>>>>>"
cat $SNAPSHOT_INFO
echo ">>>>>>"
    while read SNAP_INFO
do
SNAP_ID=`echo $SNAP_INFO | awk '{print $1}'`
echo ">>>>>>>"
echo $SNAP_ID
echo ">>>>>>>"
SNAP_DATE=`echo $SNAP_INFO | awk '{print $4}' | awk -F"T" '{print $1}'`
echo ">>>>>>>"
echo $SNAP_DATE
echo ">>>>>>>"

RETENTION_DIFF=`echo $(($(($(date -d "$DATE" "+%s") - $(date -d "$SNAP_DATE" "+%s"))) / 86400))`
echo $RETENTION_DIFF
if [ "$RETENTION" -eq "$RETENTION_DIFF" ];  ###if your retention period is more than 1 -eq to -lt :P
then
/usr/local/bin/aws ec2 delete-snapshot --snapshot-id $SNAP_ID --region $REGION --output text > /var/log/snapshot/snap_del
echo DELETING $SNAP_INFO >> $SNAP_DELETION
fi
done < $SNAPSHOT_INFO
done
echo >> $SNAP_DELETION
cat $SNAP_CREATION $SNAP_DELETION > /var/log/snapshot/mail_report
cat /var/log/snapshot/mail_report  | mail -aFrom:mohit.c@credr.com -s 'snapshot backup' $EMAIL_LIST
