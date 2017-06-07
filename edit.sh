#!/bin/bash

line=".gitattributes .gitignore"
line="$line $(find ./compilers | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)$")"
line="$line $(find ./include | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)$")"
line="$line $(find ./modules | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)$")"
line="$line $(find ./yasic | egrep ".*(fasmg|flibg|fincg|sh|md|yasic)$")"
editor $line