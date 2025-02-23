#!/bin/bash

wall "	Architecture: $(uname -a)
	CPU physical: $(grep "physical id" /proc/cpuinfo | wc -l)
	vCPU: $(grep "processor" /proc/cpuinfo | wc -l)
	Memory Usage: $(free --mega | awk '$1 == "Mem:" {print $3}')/$(free --mega | awk '$1 == "Mem:" {print $2}')MB ($(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}'))
	Disk Usage: $(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_t += $2} END {printf ("%.1fGb\n"), disk_t/1024}')/$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}')
	CPU load: $(printf "%.1f" $(expr 100 - $(vmstat 1 2 | tail -1 | awk '{printf $15}'))))
	Last boot: $(who -b | awk '$1 == "system" {print $3 " " $4}')
	LVM use: $(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
	Connections TCP: $(ss -ta | grep ESTAB | wc -l) ESTABLISHED
	User log: $(users | wc -w)
	Network: IP $(hostname -I) ($(ip link | grep "link/ether" | awk '{print $2}'))
	Sudo: $(journalctl _COMM=sudo | grep COMMAND | wc -l) cmd"

