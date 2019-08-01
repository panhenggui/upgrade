#!/bin/bash
path=/home/qdam/crontab
Log=$path/qupgrade.log
qdampath=/home/qdam/run
urldate=`date +%Y%m%d`

main()
{
    >$Log
	#备份、传输、解压run、tools
    $path/btd.sh | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] 备份、传输、解压run、tools失败！！！\033[0m"
        exit 1
    echo -e "\033[32;1m [OK] 备份、传输、解压run、tools成功。\033[0m"
    fi
    
	#修改qdata,qmdb,qmarket,qsdb配置文件
    for i in {qdata,qmdb,qmarket,qsdb}
    do
         $path/c.sh $qdampath.$urldate/$i/$i.ini $qdampath/$i/$i.ini | tee -a $Log
         if [ $? != 0 ];then
             echo -e "\033[31;1m [Failed] 修改$i的配置失败！！！\033[0m"
             exit 1
         echo -e "\033[32;1m [OK] 修改$i的配置成功。\033[0m"
         fi
    done
	
	
    $path/c.sh $qdampath.$urldate/network.ini $qdampath/network.ini | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] 修改network.ini的配置失败！！！\033[0m"
        exit 1
    echo -e "\033[32;1m [OK] 修改network.ini的配置成功。\033[0m"
    fi
            
    echo "==========>$0   结束" | tee -a $Log
    date | tee -a $Log
}
main $@;
