#!/bin/bash

line=".gitattributes .gitignore *.sh *.md *.fasmg "
if [ "$(ls -A 'libs')" ]; then line="$line libs/*"; fi
if [ "$(ls -A 'misc')" ]; then line="$line misc/*"; fi
if [ "$(ls -A 'code')" ]; then line="$line code/*"; fi
editor $line