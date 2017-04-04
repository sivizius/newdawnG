#!/bin/bash

line=".gitattributes .gitignore $(find | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)$") $(find | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)~$")"
editor $line