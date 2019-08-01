#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/qdam
rm -rf $path/run $path/tools
mv $path/run.$urldate $path/run
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run��ԭʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run��ԭ����ɹ���\033[0m"
mv $path/tools.$urldate $path/tools
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools��ԭ����ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools��ԭ�ɹ���\033[0m"
