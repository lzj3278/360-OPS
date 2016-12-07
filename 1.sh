#! /bin/bash
##################
##Created Time: 2016-12-06 13:30:18
##################

temp1=$(mktemp)
temp2=$(mktemp)
temp3=$(mktemp)

ifconfig | grep -v  '^[[:space:]]' | awk '{print $1}' | grep -v '^$' > $temp1
#ifconfig | grep -A 1 '^[[:space:]]' | grep addr | awk '{print $2}' | awk -F : '{print $2}' | grep -v '^$' > $temp2
ifconfig | grep -A 1 '^[[:space:]]'| grep inet | awk '{print $2}' > $temp2
paste $temp1 $temp2 > $temp3
#echo $temp3
cat $temp3 | while read line;do
    #key=`echo $line|awk '{print $1}'` value=`echo $line |awk '{print $2}'`
    key=`echo $line | awk '{print $1}'` value=`echo $line | awk '{print $2}'`
    echo $key $value;
done

