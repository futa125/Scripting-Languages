#!/bin/bash

dict_file=$1

Help()
{
   # Display Help
   echo
   echo "Dictionary analysis tool"
   echo "Usage: ${BASH_SOURCE[0]} [dictionary file]"
   echo
}

DictionaryAnalyzer()
{
  cut -c1 "$dict_file" | tr "[:upper:]" "[:lower:]" | sort | uniq -c | sort -nr
}

if [ "$dict_file" != "" ]; then

    if [ -f "$dict_file" ]; then
        DictionaryAnalyzer
    else
        echo "Error: File $dict_file does not exists."
        Help
    fi

else
    echo  "Error: Dictionary file not specified."
    Help
fi
