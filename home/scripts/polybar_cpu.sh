#!/bin/sh
cpu_temp=$(sensors|grep Tctl)
cpu_freq=$(lscpu | grep "CPU MHz")
if [[ ! -z "$cpu_freq" ]]
then 
  VAR=$(bc<<<"scale=2;${cpu_freq##* }/1000")
else
  VAR=$(cat /proc/cpuinfo | grep MHz | awk '{sum+=$4} END {printf "%.0f", sum/NR}')
fi
echo "${cpu_temp#*+}${VAR}Ghz"

timestamp=$(date '+%d/%m/%Y, %T')
# mpstat reports incorrectly always 8x% iddle
# top -n 1 fails when run from polybar
#cpu_iddle=$(top -n 1 | grep Cpu | awk '{printf $8}')
echo "${timestamp}, ${cpu_iddle}, ${cpu_temp#*+}, ${VAR}"
