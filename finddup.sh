#!/bin/bash

if [ $EUID -eq 0 ]; then
  echo "You are running as a root"
else
echo "********"
echo "please enter the absolute path after the script"
echo "********"
fi


FindDup() {
find $1 -type f -exec md5sum {} \; | sort > /tmp/sums-sorted.txt

ORGSUM=""
IFS=$'\n'
for i in `cat /tmp/sums-sorted.txt`; do
 DUPSUM=`echo "$i" | sed 's/ .*//'`
 DUPFILE=`echo "$i" | sed 's/^[^ ]* *//'`
 if [ "$ORGSUM" == "$DUPSUM" ]; then
  echo ln -f "$ORGFILE" "$DUPFILE"
 else
  ORGSUM="$DUPSUM"
  ORGFILE="$DUPFILE"
 fi
done
}

#echo "Please enter absolute path "

if [ ! -z "$1" -a "$1" != " " ]; then
FindDup
else
echo "Please enter absolute path "
exit 0
fi
