#!/bin/sh
df -h | grep sda7 | awk '{printf "%s(%s)\n",$4,$5}'
