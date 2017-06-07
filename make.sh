#!/bin/bash

function modes
{
  echo "[fail] valid [modes] are:"
  echo "       * yasic        (compile yasic code and create uf4 file)"
  echo "       * disasm       (disassemble fbc0 byte code and show structure)"
  echo "       * linux-amd64  (add amd64 code with linux API to uf4 file)"
}

if [[ $# -lt 2 ]]
then
  echo "[fail] usage: »./make [mode] [filename]«."
  ls
  modes
  exit
fi

if [[ ! -d "build" ]]
then
  mkdir "build"
fi
if [[ ! -d "final" ]]
then
  mkdir "final"
fi
name=$(echo $( basename $2 )| egrep -o "^[^.]*" )

echo "#!sba:log"                                            >         "build/$name.log"
echo '#a=_sivizius'                                         >>        "build/$name.log"
echo '#b=ascii\\n'                                          >>        "build/$name.log"
echo '#c=2016-03-25_07:40:04_UTC+0100'                      >>        "build/$name.log"
echo -n '#d='                                               >>        "build/$name.log"
date "+%Y-%m-%d_%H:%M:%S"                                   >>        "build/$name.log"
echo '#f=/sba/out/yalave.log'                               >>        "build/$name.log"
echo '#l=bash/en'                                           >>        "build/$name.log"
echo '#p=/sba/doc/licenses/LICENCE.txt'                     >>        "build/$name.log"
echo '#t=logfile for yalave'                                >>        "build/$name.log"
echo '#v=0.9.1.0-»Amanita muscaria«'                        >>        "build/$name.log"

if [[ ! -f $2 ]]
then
  echo "[fail] »$2« does not exist!"                        2>&1| tee "build/$name.log"
  exit
fi

case $1 in
  "yasic")
    echo "yasic@@theInputFile equ '$2'"                     >         "build/temp.fasmg"
    echo "yasic@@theFruitbotCodeVersion equ 0"              >>        "build/temp.fasmg"
    echo "include 'compilers/yasic.fasmg'"                  >>        "build/temp.fasmg"
    output="final/$name.uf4"
    echo "fasmg 'build/temp.fasmg' '$output'"               2>&1| tee "build/$name.log"
    fasmg "-e" "1" "build/temp.fasmg" "$output"             2>&1| tee "build/$name.log"
  ;;
  "disasm")
    echo "disasm@@theInputFile equ '$2'"                    >         "build/temp.fasmg"
    echo "include 'compilers/disassembler.fasmg'"           >>        "build/temp.fasmg"
    output="final/$name.fbc"
    echo "fasmg 'build/temp.fasmg' '$output'"               2>&1| tee "build/$name.log"
    fasmg "build/temp.fasmg" "$output"                      2>&1| tee "build/$name.log"
  ;;
  "linux-amd64")
    echo "compile@@theInputFile equ '$2'"                   >         "build/temp.fasmg"
    echo "include 'compilers/linux_amd64.fasmg'"            >>        "build/temp.fasmg"
    output="final/$name.uf4"
    echo "fasmg 'build/temp.fasmg' '$output'"               2>&1| tee "build/$name.log"
    fasmg "build/temp.fasmg" "$output"                      2>&1| tee "build/$name.log"
  ;;
  *)
    echo "[fail] unknown mode »$1«!"                        2>&1| tee "build/$name.log"
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