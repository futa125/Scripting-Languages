#!/bin/bash

dir=$1

Help()
{
   # Display Help
   echo
   echo "Log file analyzer"
   echo "Usage: ${BASH_SOURCE[0]} [directory]"
   echo
}

LogAnalyzer()
{
  file_list=$(find "$dir" -type f -regextype posix-extended -regex ".*([0-9]{4}-02-(0[1-9]|[12][0-9])).*")
  for file in $file_list
    do
      date=$(echo "$file" | grep -Eo "([0-9]{4}-02-(0[1-9]|[12][0-9]))" )
      echo "datum: $date"
      for _ in {1..50}; do echo -n "-"; done
      echo
      cut -d '"' "$file" -f2 | sort | uniq -c | sort -nr
      echo
  done
}

if [ "$dir" != "" ]; then

    if [ -d "$dir" ]; then
        LogAnalyzer
    else
        echo "Error: Directory $dir does not exists."
        Help
    fi

else
    echo  "Error: Directory not specified."
    Help
fi
