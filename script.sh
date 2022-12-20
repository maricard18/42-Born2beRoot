#!/bin/bash

arch=$(uname -a)

fcpu=$(nproc)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)

rammemory=$(free -m | grep Mem | awk '{printf("%d/%dMB (%.2f%%)"), $3, $2, $3/$2*100}')

diskmemory=$(df -Bg --total | grep total | awk '{printf("%d/%dGb (%.2f%%)"), $3, $2, $3/$2*100}')

cpuload=$(top -bn1 | grep "^%Cpu" | awk '{printf ("%.1f%%"), $2}')

lastboot=$(who -b | awk '{print $3 " " $4}')

lvm=$(lsblk | grep lvm | wc -l)
checklvm=$(if [ $lvm == 0 ]; then echo no; else echo yes; fi)

tcp=$(ss -t | grep ESTAB | wc -l)

users=$(who | wc -l)

ipv4=$(ip r | grep src | awk '{print $9}')
mac=$(ip link | grep link/ether | awk '{print $2}')

sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "	#Architecture: $arch
	#CPU physical : $fcpu
	#vCPU : $vcpu
	#Memory Usage: $rammemory
	#Disk Usage: $diskmemory
	#CPU load: $cpuload
	#Last boot: $lastboot
	#LVM use: $checklvm
	#Connections TCP : $tcp ESTABLISHED
	#User log: $users
	#Network: IP $ipv4 ($mac)
	#Sudo : $sudo cmd"
