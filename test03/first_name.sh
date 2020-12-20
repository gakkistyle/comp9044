#!/bin/sh

egrep 'COMP2041|COMP9041' "$1" | cut -d'|' -f3 | cut -d',' -f2 | sed 's/^ *//;s/ *$//' | cut -d' ' -f1 | sort | uniq -c | sort -r | head -n 1 | sed 's/^ *//' | cut -d' ' -f2
