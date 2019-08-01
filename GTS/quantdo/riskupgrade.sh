#!/bin/bash
path=/home/quantdo/crontab
Log=$path/qupgrade.log
riskpath=/home/quantdo/riskStorm
urldate=`date +%Y%m%d`

main()
{
    >$Log
    #run、tools备份、传输tar包解压
    $path/riskbtd.sh | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] run、tools备份、传输tar包解压失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] run、tools备份、传输tar包解压成功。\033[0m" | tee -a $Log
    fi
    
    $path/c.sh $riskpath.$urldate/shell/run.sh $riskpath/shell/run.sh | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] 修改run配置文件失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] 修改run配置文件成功。\033[0m" | tee -a $Log
    fi
    ##修改配置文件
    for i in {c3p0-config.xml,IceConfig.ini,configure.properties}
    do
         $path/c.sh $riskpath.$urldate/resources/$i $riskpath/resources/$i | tee -a $Log
         if [ $? != 0 ];then
             echo -e "\033[31;1m [Failed] 修改${i}配置文件失败！！！\033[0m" | tee -a $Log
             exit 1
         echo -e "\033[32;1m [OK] 修改${i}配置文件成功。\033[0m" | tee -a $Log
         fi
    done
  

    echo "==========>$0   结束" | tee -a $Log
    date | tee -a $Log 
}
main $@;
