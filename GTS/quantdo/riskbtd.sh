#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/quantdo/riskStorm

#备份webapps
echo "备份riskstorm"
cp -r $path $path.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] riskstorm备份失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] riskstorm备份成功。\033[0m" 


#传输quantdo包
echo "传输riskstorm包"
cd $path
mv ~/upgrade/riskStorm.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] riskstorm包传输失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] riskstorm包传输成功。\033[0m" 

tar -xvf riskStorm.tar.gz > /dev/null 
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] riskstorm包解压失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] riskstorm包解压成功。\033[0m" 

