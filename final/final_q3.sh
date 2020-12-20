#!/bin/sh

sort -t'|' -k2|uniq |cut -d'|' -f2|sort|uniq -c|egrep '^ +2 [0-9]+'|egrep -o '[0-9]{7}'