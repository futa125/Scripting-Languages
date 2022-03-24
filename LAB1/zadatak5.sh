#!/bin/bash

dir=$1
filename=$2

Help()
{
   # Display Help
   echo
   echo "File search tool"
   echo "Usage: ${BASH_SOURCE[0]} [directory] [filename]"
   echo
}

FileFinder()
{
  echo "Directory: $dir"
  echo "Filename: $filename"

  find "$dir" -type f -name "$filename" -exec cat {} ';' | wc -l
}

if [ "$dir" != "" ] && [ "$filename" != "" ]; then

    if [ -d "$dir" ]; then
        FileFinder
    else
        echo "Error: Directory $dir does not exists."
        Help
    fi

else
    echo  "Error: Directory or filename not specified."
    Help
fi
