#!/bin/bash

grep -iwE "banana|jabuka|jagoda|dinja|lubenica" namirnice.txt

grep -iwvE "banana|jabuka|jagoda|dinja|lubenica" namirnice.txt

grep -wrE "\b[A-Z]{3}[0-9]{6}|^[A-Z]{3}[0-9]{6}\b" ~/projekti/

find ./ -type f -mtime +7 -mtime -14 -ls

for i in $(seq 1 15); do echo "$i"; done

for i in $(seq 1 15); do echo "$i"; if [ "$i" = 15 ]; then kraj=$i; fi; done
echo "$kraj"
for i in {1..15}; do echo "$i"; if [ "$i" = 15 ]; then kraj=$i; fi; done
echo "$kraj"
