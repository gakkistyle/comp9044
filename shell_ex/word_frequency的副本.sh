#!/bin/bash

sed 's/[ ]/\n/g' "$@"|
tr A-Z a-z|
sed "s/[^a-z']//g"|
egrep -v '^$'|
sort|
uniq -c|
sort -n