#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/quantdo/apache-tomcat-8.0.41/webapps

#备份webapps
echo "备份webapps"
cp -r $path/ $path.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] webapps备份失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] webapps备份成功。\033[0m" 


#传输quantdo包
echo "传输quantdo包"
cd ~/apache-tomcat-8.0.41/webapps
rm -rf *
mv ~/upgrade/quantdo.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] quantdo包传输失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] quantdo包传输成功。\033[0m" 

tar -xvf quantdo.tar.gz > /dev/null 
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] quantdo包解压失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] quantdo包解压成功。\033[0m" 

