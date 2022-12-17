#!/bin/bash

arch=$(uname -a)

fcpu=$(getconf _NPROCESSORS_ONLN)
vcpu=$(getconf _NPROCESSORS_ONLN)

rammemory=$(free -m | grep Mem | awk '{printf("%d/%d (%.2f%%)") , $3, $2, $3/$2*100]')
diskmemory=$( )
cpuload=$( )

lastboot=$(who -b | awk '{print $3 " " $4}')

lvm=$(lsblk | grep "lvm" | wc - l)
checklvm=$(if [ $lvm -eq 0 ]; then echo no; else echo yes; fi)

tcp=$(ss -t | grep ESTAB | wc - l)
checktcp=$(if [ $tcp -eq 0]; then echo NOT ESTABLISHED; else echo ESTABLISHED; fi)

users=$(who | wc -l)

ipv4=$(ifconfig | grep broadcast | awk '{print $2}') 
mac=$(ifconfig | grep ether | awk '{print $2}')

sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "	#Architecture: $arch
		#CPU physical : $fcpu 
		#vCPU: $vcpu
		#Memory Usage: $rammemory
		#Disk Usage: NO
		#CPU load: NO
		#Last boot: $lastboot
		#LVM use: $checklvm
		#Connections TCP : $tcp $checktcp
		#User log: $user
		#Network: IP $ipv4 ($mac)
		#Sudo : $sudo cmd
	 "
