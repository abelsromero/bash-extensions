#!/bin/sh
cpu_temp=$(sensors|grep Tctl)
cpu_freq=$(lscpu|grep "CPU MHz")
if [[ -z "$cpu_freq" ]]
then 
  cpu_freq=$(cat /proc/cpuinfo | grep MHz | awk '{sum+=$4} END {printf "%.0f", sum/NR}')
else
  cpu_freq=$(bc<<<"scale=2;${cpu_freq##* }/1000")
fi
#cpu_temp has 2 "useful" trailing spaces 
echo "${cpu_temp#*+}${cpu_freq}Ghz"

timestamp=$(date '+%d/%m/%Y,%T')
# mpstat reports incorrectly always 8x% iddle
# top -n 1 fails when run from polybar
# cpu_iddle=$(top -n 1 | grep Cpu | awk '{printf $8}')
[[ "$CPU_LOG" == "true" ]] && echo "${timestamp},${cpu_temp#*+},${cpu_freq}" >> ~/cpu_mon.log
