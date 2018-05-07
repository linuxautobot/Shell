#!/bin/bash
#declare cpuutil=6.99921021
starttime=$(date -d '6 hour ago' +%FT%T)
endtime=$(date +%FT%T)

freeablemem=$(aws cloudwatch  get-metric-statistics --metric-name FreeableMemory  --start-time $starttime --end-time $endtime --period 3600 --namespace AWS/RDS --statistics Average --dimensions  --query Datapoints[0].Average | cut -d . -f 1 )

cpuutil=$(aws cloudwatch  get-metric-statistics --metric-name CPUUtilization  --start-time $starttime --end-time $endtime  --period 3600  --namespace AWS/RDS --statistics Average --dimensions --query Datapoints[0].Average | cut -d . -f 1 )

dbcon=$(aws cloudwatch  get-metric-statistics --metric-name DatabaseConnections  --start-time $starttime --end-time $endtime  --period 3600  --namespace AWS/RDS --statistics Average --dimensions --query Datapoints[0].Average | cut -d . -f 1 )


#echo -e "CPUUtilization:$cpuutil"

#echo -e "DatabaseConnections:$dbcon"
#echo -e "FreeableMemory:$freeablemem"

low=10

output="Load Average: $cpuutil | DatabaseConnections:$dbcon | FreeableMemory:$freeablemem"

if [ "$cpuutil" -le "$low" ]
then
    echo "OK- $output"
    exit 0
elif [ "$cpuutil" -ge '15' ]
then
mail -s "RDS WARNING  " -c "Devops@gmail.com"  "techops@gmail.com"   <<<  " RDS WARNING - $output" &&
    echo "WARNING- $output"
    exit 1
elif [ "$cpuutil" -ge "30" ]
then
mail -s "RDS CRITICAL " -c "Devops@gmail.com"  "techops@gmail.com"  <<<  " RDS CRITICAL- $output" &&
    echo "CRITICAL - $output"
    exit 2
else
echo 'UNKNOWN - $output'
exit 3
fi
