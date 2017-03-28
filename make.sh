#!/bin/bash

function modes
{
  echo "[fail] valid [modes] are:"
  echo "       * src2fbc0 (source to fbc0 byte code)"
}

if [[ $# -lt 2 ]]
then
  echo "[fail] usage: »./make [mode] [filename]«."
  ls
  modes
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
  "yasic2fbc0")
    if [[ -f $2 ]]
    then
      echo "include 'libs/main.flibg'"                        >         "make/temp.fasmg"
      echo "format uf4"                                       >>        "make/temp.fasmg"
      echo "  import 'display'"                               >>        "make/temp.fasmg"
      echo "  import 'fruitbotcode_v0'"                       >>        "make/temp.fasmg"
      echo "  code yasic"                                     >>        "make/temp.fasmg"
      echo "    include '$2'"                                 >>        "make/temp.fasmg"
      echo "  end code"                                       >>        "make/temp.fasmg"
      echo "end format"                                       >>        "make/temp.fasmg"
      output="make/$name.uf4"
      fasmg "make/temp.fasmg" "$output"
    else
      echo "[fail] »$2« does not exist!"
      exit
    fi
  ;;
  "fbc02amd64")
    echo "[fail] not implemented yet :-/!"                  | tee     "make/$name.log"
  ;;
  *)
    echo "[fail] unknown mode »$1«!"                        | tee     "make/$name.log"
    modes
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