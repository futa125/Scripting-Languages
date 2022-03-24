#!/bin/bash

dir1=$1
dir2=$2

Help()
{
   # Display Help
   echo
   echo "Directory sync tool"
   echo "Usage: ${BASH_SOURCE[0]} [directory 1] [directory 2]"
   echo
}

DirectorySync()
{
  dir1_files=$(find "$dir1" -type f | sort -n)
  dir2_files=$(find "$dir2" -type f | sort -n)

  for dir1_file in $dir1_files
    do
      dir1_file_name=$(basename "$dir1_file")
      dir2_file=$(find "$dir2" -type f -name "$dir1_file_name")
      if [ "$dir2_file" = "" ]; then
        echo "$dir1_file --> $dir2"
      fi

      if [ "$dir2_file" != "" ] && [ "$dir1_file" -nt "$dir2_file" ]; then
        echo "$dir1_file --> $dir2"
      fi
  done

  for dir2_file in $dir2_files
    do
      dir2_file_name=$(basename "$dir2_file")
      dir1_file=$(find "$dir1" -type f -name "$dir2_file_name")
      if [ "$dir1_file" = "" ]; then
        echo "$dir2_file --> $dir1"
      fi

      if [ "$dir1_file" != "" ] && [ "$dir2_file" -nt "$dir1_file" ]; then
        echo "$dir2_file --> $dir1"
      fi
  done
}

if [ "$dir1" != "" ] && [ "$dir2" != "" ]; then

    if [ -d "$dir1" ] && [ -d "$dir2" ]; then
        DirectorySync
    elif ! [ -d "$dir1" ]; then
        echo "Error: Directory $dir1 does not exists."
        Help
    elif ! [ -d "$dir2" ]; then
        echo "Error: Directory $dir2 does not exists."
        Help
    fi

else
    echo  "Error: Directories not specified."
    Help
fi
