#!/bin/bash
 
OUTPUT_LOG=/home/
UPDATE_SCRIPT='DEBIAN_FRONTEND=noninteractive sudo apt-get update -y && DEBIAN_FRONTEND=noninteractive sudo apt-get dist-upgrade -y && DEBIAN_FRONTEND=noninteractive sudo apt-get autoremove -y && DEBIAN_FRONTEND=noninteractive sudo apt-get clean -y && DEBIAN_FRONTEND=noninteractive sudo reboot'
HOSTS=' ' # place hosts here ex: pi@10.0.0.1 or use args

# Example: -h pi@127.0.0.1
while getopts ":h:" opt; do
    case $opt in
        h)
            HOSTS=${OPTARG}
            echo ${HOSTS}
    esac
done

date=`date '+%Y-%m-%d'`
time=`date '+%H-%M-%S'`

for host in ${HOSTS}
do
    ssh ${host} ${UPDATE_SCRIPT} > ${OUTPUT_LOG}/${host}_Update_${date}_${time}.log
    # if additional stuff is desired to only be ran on one host after the reboot
    #if [ ${host} = ' ' ] 
    #then
        #sleep 60
        #ssh ${host} 'pihole -up && exit' >> ${OUTPUT_LOG}/${host}_Update_${date}_${time}.log
    #fi
done
