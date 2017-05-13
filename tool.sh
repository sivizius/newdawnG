start=$(date +%s)
echo "#!sba:logfile" > "tool.log"
for f in $(find ../ )
do
  if [[ -f $f ]]
  then
    fil=$(echo $f   | grep -o "/.*$")
    dir=$(echo $fil | grep -o "^/[^/]*")
    typ=$(echo $fil | grep -o "[^.]*$")
    if [[ "$dir" = "/.git" ]] ||
       [[ "$dir" = "/newdawn3" ]]
    then
      :
    elif [[ "$dir" = "/stuff" ]] ||
         [[ "$dir" = "/yasic" ]] ||
         [[ "$typ" = "sh" ]]
    then
      echo "$fil..."
      mv "..$fil" ".$fil" >> "tool.log"
    elif [[ "$typ" = "fasmg" ]] ||
         [[ "$typ" = "flibg" ]]
    then
      echo "$fil..."
      echo "include 'tool.fincg'" > "tool.fasmg"
      echo "parse '..$fil'" >> "tool.fasmg"
      if [[ -f ".$fil" ]]
      then
        :
      else
        fasmg "tool.fasmg" ".$fil" >> "tool.log"
      fi
    else
      :
#      echo "$fil"
    fi
  fi
done
stop=$(date +%s)
echo "Δt = " "$(python $stop - $start)" | tee -a "tool.log"