#!/bin/bash

proba="Ovo je proba"
echo "$proba"

lista_datoteka=$(ls ./*)
echo "$lista_datoteka"

proba3=""
for _ in $(seq 1 3); do proba3="$proba3$proba. "; done

a=4
b=3
c=7
d=$(($((a + 4)) * $((b % c))))
echo "a:$a, b:$b, c:$c, d:$d"

broj_rijeci=$(wc -w ./*.txt)
echo "$broj_rijeci"

ls ~
