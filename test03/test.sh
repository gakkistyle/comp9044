#!/bin/sh

egrep '^COMP[29]041' enrollments.txt|cut -d'|' -f3|cut -d',' -f2|sed 's/^ *//'|cut -d' ' -f1|sort|uniq -c|sort -nr|head -1|sed 's/^ *//'|cut -d' ' -f2
