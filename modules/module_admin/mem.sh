#!/bin/bash
process=`ps aux | grep $1 | head -1 | awk '{print $2}'`
memory=`cat /proc/$process/status | grep -i VMSIZE`
echo $memory
