#!/bin/bash

if [[ $# -lt 2 ]]
then
  echo "[fail] usage: »./make [mode] [filename]«."
  exit
fi

name=$( basename $2 )

echo "#!sba:log"                                            >         "make/$name.log"
echo '#a=_sivizius'                                         >>        "make/$name.log"
echo '#b=ascii\\n'                                          >>        "make/$name.log"
echo '#c=2016-03-25_07:40:04_UTC+0100'                      >>        "make/$name.log"
echo -n '#d='                                               >>        "make/$name.log"
date "+%Y-%m-%d_%H:%M:%S"                                   >>        "make/$name.log"
echo '#f=/sba/out/yalave.log'                               >>        "make/$name.log"
echo '#l=bash/en'                                           >>        "make/$name.log"
echo '#p=/sba/doc/licenses/LICENCE.txt'                     >>        "make/$name.log"
echo '#t=logfile for yalave'                                >>        "make/$name.log"
echo '#v=0.9.1.0-»Amanita muscaria«'                        >>        "make/$name.log"

case $1 in
  "src2fbc0")
    fasmg "-D__fbc_version__=0" "$2" "make/$name.uf4"
    output="make/$name.uf4"
  ;;
  "fbc02amd64")
    echo "[fail] not implemented yet :-/!"                  | tee     "make/$name.log"
  ;;
  *)
    echo "[fail] unknown mode »$1«! valid modes are:"       | tee     "make/$name.log"
    echo "       * src2fbc0 (source to fbc0 byte code)"     | tee     "make/$name.log"
    exit
  ;;
esac

read -p "hex? " yn
case "$yn" in
  "y"|"Y"|"j"|"J"|"yes"|"ja")
    ghex "$output"
  ;;
esac
read -p "cat? " yn
case "$yn" in
  "y"|"Y"|"j"|"J"|"yes"|"ja")
    cat "$output"
  ;;
esac