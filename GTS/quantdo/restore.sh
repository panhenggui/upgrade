#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/quantdo/apache-tomcat-8.0.41/webapps
rm -rf $path
mv $path.$urldate $path
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] webapps还原失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] webapps还原传输成功。\033[0m"
