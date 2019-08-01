#!/bin/bash
urldate=`date +%Y%m%d`
path=/home/qdam

#����run
echo "����run"
cp -r $path/run $path/run.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run����ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run���ݳɹ���\033[0m" 

#����tools
echo "����tools"
cp -r $path/tools $path/tools.$urldate
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools����ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools���ݳɹ���\033[0m" 

#����run��tools��
echo "����run��tools��"
cd $path/run
mv $path/upgrade/GTS_*.ini.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run��ini����ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run��ini����ɹ���\033[0m" 

tar -xvf GTS_*.ini.tar.gz > /dev/null 
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run��ini��ѹʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run��ini��ѹ�ɹ���\033[0m" 

mv $path/upgrade/GTS_*.run.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run��run����ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run��run����ɹ���\033[0m" 

tar -xvf GTS_*.run.tar.gz > /dev/null
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] run��run��ѹʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] run��run��ѹ�ɹ���\033[0m" 

cd $path/tools/
mv $path/upgrade/GTS_*.tools.tar.gz .
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools������ʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools������ɹ���\033[0m" 

tar -xvf GTS_*.tools.tar.gz > /dev/null
if [ $? != 0 ];then
    echo -e "\033[31;1m[Failed] tools����ѹʧ�ܣ�����\033[0m" 
    exit 1
fi
echo -e "\033[32;1m[OK] tools����ѹ�ɹ���\033[0m" 
