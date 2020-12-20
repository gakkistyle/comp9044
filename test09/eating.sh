#!/bin/sh

cat $1|sed s/\\[//g | sed s/\\]\,*//g|egrep -v '^\s*$'|cut -d ':' -f2|cut -d ',' -f1|sed s/\"//g|sed 's/^ *//'|sort|uniq
