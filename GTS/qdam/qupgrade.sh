#!/bin/bash
path=/home/qdam/crontab
Log=$path/qupgrade.log
qdampath=/home/qdam/run
urldate=`date +%Y%m%d`

main()
{
    >$Log
	#���ݡ����䡢��ѹrun��tools
    $path/btd.sh | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] ���ݡ����䡢��ѹrun��toolsʧ�ܣ�����\033[0m"
        exit 1
    echo -e "\033[32;1m [OK] ���ݡ����䡢��ѹrun��tools�ɹ���\033[0m"
    fi
    
	#�޸�qdata,qmdb,qmarket,qsdb�����ļ�
    for i in {qdata,qmdb,qmarket,qsdb}
    do
         $path/c.sh $qdampath.$urldate/$i/$i.ini $qdampath/$i/$i.ini | tee -a $Log
         if [ $? != 0 ];then
             echo -e "\033[31;1m [Failed] �޸�$i������ʧ�ܣ�����\033[0m"
             exit 1
         echo -e "\033[32;1m [OK] �޸�$i�����óɹ���\033[0m"
         fi
    done
	
	
    $path/c.sh $qdampath.$urldate/network.ini $qdampath/network.ini | tee -a $Log
    if [ $? != 0 ];then
        echo -e "\033[31;1m [Failed] �޸�network.ini������ʧ�ܣ�����\033[0m"
        exit 1
    echo -e "\033[32;1m [OK] �޸�network.ini�����óɹ���\033[0m"
    fi
            
    echo "==========>$0   ����" | tee -a $Log
    date | tee -a $Log
}
main $@;
