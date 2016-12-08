#! /bin/bash
##############################
# File Name: 6.sh
# Author: zhongjie.li
# email: zhongjie.li@viziner.cn
# Created Time: 2016-12-07 15:42:03
# Last Modified: 2016-12-08 09:22:50
##############################

save_file="/tmp/`date +%F`-cpuinfo"

cpuinfo=$(top -bn 2 -d 0.8 | grep "Cpu"| tail -n1)
#echo $cpuinfo

if [ ! -e $save_file ];then
    cat << EOF >>$save_file
                CPU信息统计
    注：
    us：用户态使用的cpu时间比
    sy：系统态使用的cpu时间比
    ni：用做nice加权的进程分配的用户态cpu时间比
    id：空闲的cpu时间比
    wa：cpu等待磁盘写入完成时间
    hi：硬中断消耗时间
    si：软中断消耗时间
    st：虚拟机偷取时间
EOF


    echo -e "\t\t\t\t\tdate:`date +%F`\n" >> $save_file
    echo -e "times:\t\t\t\tus:\t\tsy:\t\tni:\t\tid:\t\twa:\t\thi:\t\tsi:\t\tst:\t\n" >> $save_file
fi

us=$(echo $cpuinfo |awk '{print $2}')
sy=$(echo $cpuinfo |awk '{print $4}')
#totle=`echo "$us + $sy"| bc`
ni=$(echo $cpuinfo |awk '{print $6}')
id=$(echo $cpuinfo |awk '{print $8}')
wa=$(echo $cpuinfo |awk '{print $10}')
hi=$(echo $cpuinfo |awk '{print $12}')
si=$(echo $cpuinfo |awk '{print $14}')
st=$(echo $cpuinfo |awk '{print $16}')
hours=$(date +%T)
echo -e "${hours}\t\t\t${us}\t\t${sy}\t\t${ni}\t\t${id}\t${wa}\t\t${hi}\t\t${si}\t\t${st}" >> $save_file

