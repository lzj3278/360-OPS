#!/usr/bin/python
# -*- coding:utf-8 -*-

############################
# File Name: 1.py
# Author: zhongjie.li
# Created Time: 2016-12-06 13:58:11
############################

'''
解析ifconfig 命令的标准输出，返回一个hash。key 是网卡名称value 是对应的ip。

'''
import subprocess
import re
# from pprint import pprint
pattern = re.compile(r'(?<![\.\d])(?:\d{1,3}\.){3}\d{1,3}(?![\.\d])')
pattern_1 = re.compile(r'^\ ')
temp_log = open('/tmp/g.log', 'wb')
subprocess.call('ifconfig', stdout=temp_log)


def hash_ip():
    ip_list = []  # 匹配出的ip
    file_list = []  # 匹配出的每一行
    file_1 = []  # 匹配出的网卡名

    with open('/tmp/g.log') as f:
        for item in f.readlines():
            a = pattern_1.findall(item)
            if len(item) > 1:
                b = item.split()[0]
                if len(a) == 0:
                    file_1.append(b)
            item1 = item.strip()
            if len(item1):
                file_list.append(item1)
    for i in range(len(file_list) - 1):
        ip_li = file_list[i].split()[1]
        ip_1 = pattern.findall(ip_li)
        if len(ip_1) > 0:
            ip_list.append(ip_1[0])
    dictionary = dict(zip(file_1, ip_list))
    print dictionary
if __name__ == '__main__':
    hash_ip()
