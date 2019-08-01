#!/bin/bash
path=/home/quantdo/crontab
Log=$path/qupgrade.log
quantdopath=/home/quantdo/apache-tomcat-8.0.41/webapps
urldate=`date +%Y%m%d`

main()
{
    >$Log
    #run、tools备份、传输tar包解压
    $path/btd.sh | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] run、tools备份、传输tar包解压失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] run、tools备份、传输tar包解压成功。\033[0m" | tee -a $Log
    fi
    
    sed -i '8d;42d' $quantdopath/quantdo/WEB-INF/web.xml
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] 去掉web.xml的注释失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] 去掉web.xml的注释成功。\033[0m" | tee -a $Log
    fi

    ##修改qdata、qmdb、qmarket、qsdb配置文件
    for i in {c3p0-config.xml,configure.properties,frameworkConfig.properties}
    do
         $path/c.sh $quantdopath.$urldate/quantdo/WEB-INF/classes/$i $quantdopath/quantdo/WEB-INF/classes/$i | tee -a $Log
         if [ $? != 0 ];then
             echo -e "\033[31;1m [Failed] 修改${i}配置文件失败！！！\033[0m" | tee -a $Log
             exit 1
         echo -e "\033[32;1m [OK] 修改${i}配置文件成功。\033[0m" | tee -a $Log
         fi
    done
    sed -i "/const systemName =/c `sed -n '/const systemName =/p' $quantdopath.$urldate/quantdo_page/pages/app.js`" $quantdopath/quantdo_page/pages/app.js
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] app.js修改失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] app.js修改成功。\033[0m" | tee -a $Log
    fi

    sed -i "/<prop key="url">hsdpHttp/c '@`sed -n '/<prop key="url">hsdpHttp/p' $quantdopath.$urldate/quantdo/WEB-INF/spring/consumer-standard-hsdp.xml`'@" $quantdopath/quantdo/WEB-INF/spring/consumer-standard-hsdp.xml
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] spring/consumer-standard-hsdp.xml修改失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] spring/consumer-standard-hsdp.xml修改成功。\033[0m" | tee -a $Log
    fi

    sed -i "s/'@//g" $quantdopath/quantdo/WEB-INF/spring/consumer-standard-hsdp.xml
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] 去掉consumer-standard-hsdp.xml中的'@字符失败！！！\033[0m" | tee -a $Log
        exit 1
    echo -e "\033[32;1m [OK] 去掉consumer-standard-hsdp.xml中的'@字符成功。\033[0m" | tee -a $Log
    fi

  
    echo "==========>$0   结束" | tee -a $Log
    date | tee -a $Log 
}
main $@;
