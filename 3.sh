#! /bin/bash
##################
##Created Time: 2016-12-07 09:59:42
##################


# 对cron定时任务进行选择性的开启或者关闭

[ $UID -ne 0 ] && echo "please  use root to excute"
[ -e /etc/init.d/functions  ] && . /etc/init.d/functions || exit
crontab_temp_file=$(mktemp)
crontab_file=/var/spool/cron/root

crontab -l > $crontab_temp_file
line=$(cat $crontab_temp_file | wc -l)

crontab_list(){
    echo -e "\n\033[32m crontab as follows:\033[0m\n"
    cat -n $crontab_file
}

input_num(){
    while true; do
        echo -e "\n\033[32mplease input a task number: or q (quit)\033[0m\n"
        read num
        if [ $num == 'q' ];then
            break
        elif [ $num -le 0 -o $num -gt $line ];then
            echo "\n\033[32minput error! please input again:\033[0m\n"
            continue
        else
            break
        fi
    done

}
crontab_list
input_num

while true;do
    read -p "please input to perform operations:[ stop | start | quit ]" oper

    case $oper in
        quit|q):
            break
            ;;
        start):
            selected=$(head -$num $crontab_temp_file | tail -n 1)
            echo $selected | grep '^#' &> /dev/null

            if [ $? -eq 0 ];then
                sed -i "$num s/^#//" $crontab_temp_file
                cat $crontab_temp_file > $crontab_file
                action "success!" /bin/true
                crontab_list
                input_num
                continue
            else
                echo -e "\n\033[32mthis task is already start\033[0m\n"
            fi
            ;;
        stop):
            selected_stop=$(head -$num $crontab_temp_file | tail -n 1)
            echo $selected_stop | grep -v '^#' &> /dev/null
            if [ $? -eq 0 ];then
                sed -i "$num s/^/#/" $crontab_temp_file
                cat $crontab_temp_file > $crontab_file
                action "success!" /bin/true
                crontab_list
                input_num
                continue
            else
                echo -e "\n\033[32mthis task is already stop\033[0m\n"
            fi
            ;;
    esac
done
rm  $crontab_temp_file
