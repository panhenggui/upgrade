#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/qdam

#备份run
echo "备份run"
cp -r $path/run $path/run.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run备份失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run备份成功。\033[0m" 

#备份tools
echo "备份tools"
cp -r $path/tools $path/tools.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools备份失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools备份成功。\033[0m" 

#传输run、tools包
echo "传输run、tools包"
cd $path/run
mv $path/upgrade/GTS_*.ini.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run包ini传输失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run包ini传输成功。\033[0m" 

tar -xvf GTS_*.ini.tar.gz > /dev/null 
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run包ini解压失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run包ini解压成功。\033[0m" 

mv $path/upgrade/GTS_*.run.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run包run传输失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run包run传输成功。\033[0m" 

tar -xvf GTS_*.run.tar.gz > /dev/null
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run包run解压失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run包run解压成功。\033[0m" 

cd $path/tools/
mv $path/upgrade/GTS_*.tools.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools包传输失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools包传输成功。\033[0m" 

tar -xvf GTS_*.tools.tar.gz > /dev/null
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools包解压失败！！！\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools包解压成功。\033[0m" 
