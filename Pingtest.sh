#!/bin/bash
PingIP=12.27.224.1
DefGateEth0=10.33.100.1
DefGateWlan0=172.20.10.1
PingDesk1=10.33.100.61
PingDesk2=10.33.101.106
pingcount=120
iwconfigcount=2

TestDate=$(date +"%c"| tr " " "_")

mkdir ~/Desktop/$TestDate/

sudo route add -net 0.0.0.0 gw $DefGateEth0 eth0
sudo route add -net 0.0.0.0 gw $DefGateWlan0 wlan0
sudo sysctl -w net.ipv4.conf.eth0.rp_filter=0
sudo sysctl -w net.ipv4.conf.wlan0.rp_filter=0
sudo sysctl -w net.ipv4.conf.all.rp_filter=0

echo "logfile /home/cmh/Desktop/"$TestDate"/eth0Def.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/eth0Def.js
screen -dmSL Eth0Def ping -I eth0 -c $pingcount $DefGateEth0
sleep 1

echo "logfile /home/cmh/Desktop/"$TestDate"/wlan0Def.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/wlan0Def.js
screen -dmSL Wlan0Def ping -I wlan0 -c $pingcount $DefGateWlan0
sleep 1

echo "logfile /home/cmh/Desktop/"$TestDate"/eth0PingIP.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/eth0PingIP.js
screen -dmSL Eth0PingIP ping -I eth0 -c $pingcount $PingIP
sleep 1

echo "logfile /home/cmh/Desktop/"$TestDate"/wlan0PingIP.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/wlan0PingIP.js
screen -dmSL wlan0PingIP ping -I wlan0 -c $pingcount $PingIP
sleep 1

echo "logfile /home/cmh/Desktop/"$TestDate"/eth0PingDesk1.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/eth0PingDesk1.js
screen -dmSL eth0PingDesk1 ping -I eth0 -c $pingcount $PingDesk1
sleep 1

echo "logfile /home/cmh/Desktop/"$TestDate"/eth0PingDesk2.js">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/eth0PingDesk2.js
screen -dmSL eth0PingDesk2 ping -I eth0 -c $pingcount $PingDesk2
sleep 1

for i in {0..3}
do
echo "logfile /home/cmh/Desktop/"$TestDate"/iwconfig.txt">~/.screenrc
date +"%T">>~/Desktop/"$TestDate"/iwconfig.txt
screen -dmSL iwconfig iwconfig wlan0
sleep 60
done


sleep 10


file=/home/cmh/Desktop/$TestDate/eth0Def.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData1 = [' $file
sed -i '$a0];' $file

file=/home/cmh/Desktop/$TestDate/wlan0Def.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData2 = [' $file
sed -i '$a0];' $file

file=/home/cmh/Desktop/$TestDate/eth0PingIP.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData3 = [' $file
sed -i '$a0];' $file

file=/home/cmh/Desktop/$TestDate/wlan0PingIP.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData4 = [' $file
sed -i '$a0];' $file

file=/home/cmh/Desktop/$TestDate/eth0PingDesk1.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData5 = [' $file
sed -i '$a0];' $file

file=/home/cmh/Desktop/$TestDate/eth0PingDesk2.js
sed -i '1d' $file
sed -i 's/[^,]*time=//' $file
sed -i 's@ ms@,@' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '$d' $file
sed -i '1cvar PingData6 = [' $file
sed -i '$a0];' $file

cp -r ~/Desktop/Graph/* /home/cmh/Desktop/$TestDate/
