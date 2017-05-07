#!/bin/bash
exec < /dev/tty
oldstty=$(stty -g)
stty raw -echo min 0
tput u7 > /dev/tty
sleep 1
IFS=';' read -r row col
stty $oldstty
