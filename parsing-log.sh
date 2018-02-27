#!/bin/bash
err=0
read -p "enter the absoulet path of log file : " logFile
smallsample=$(expr `du -s $logFile | awk  {'print $1'}`  / 2 )
split -l $smallsample $logFile  uniquename

ab=$(ls -rth | grep  uniquename)

for a in $ab ; do

no404=$(grep -c 404 $a)
err=$(($err + $no404))
#echo echo "number of 404 $err"
responsecode=$(awk {'print $10'} $a)  #redirect to if want
#echo $responsecode
code=$(awk {'print $10'} $a | wc -l)
rm  $a
done
echo echo "number of 404 $err"
echo "number response code is $code"
