cpu=`ps aux | grep $1 | head -1 | awk '{print $3}'`
echo -e "CPU usage: " $cpu "%"
