#!/bin/sh

cut -d'|' -f2-3 | sort|uniq|cut -d',' -f2|sed 's/^ *//;s/ *$//'|cut -d' ' -f1| sort