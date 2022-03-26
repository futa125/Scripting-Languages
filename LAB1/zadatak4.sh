#!/bin/bash

dir=$1

Help()
{
   # Display Help
   echo
   echo "Image sorting tool"
   echo "Usage: ${BASH_SOURCE[0]} [directory]"
   echo
}

ImageSorter()
{
  for month in {01..12}
    do
      file_list=$(find "$dir" -type f -regextype posix-extended -regex ".*[0-9]{4}${month}[0-9]{2}_[0-9]{4}.*.jpg" \
      -printf "%f\n" | sort -n)
      echo
      date="$month-2020"
      echo "$date :"
      for _ in {1..10}; do echo -n "-"; done
      echo

      i=0
      for file in $file_list
        do
          i=$((i + 1))
          echo "$i. $file"
      done

      for _ in {1..3}; do echo -n "-"; done
      echo -n " Ukupno: $i slika "
      for _ in {1..4}; do echo -n "-"; done
      echo
  done
}

if [ "$dir" != "" ]; then

    if [ -d "$dir" ]; then
        ImageSorter
    else
        echo "Error: Directory $dir does not exists."
        Help
    fi

else
    echo  "Error: Directory not specified."
    Help
fi
