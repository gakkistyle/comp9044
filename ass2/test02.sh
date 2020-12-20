#!/bin/sh

first=$1
second=$2

test $first -lt 5 -a $second -gt 3 && echo good