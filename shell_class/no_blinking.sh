#!/bin/bash

for file in html_files/*.html
do
    if  egrep "<blink>" "$file" >/dev/null
    then
          echo "Blink tag"
          rm html_files/"$file"
done
