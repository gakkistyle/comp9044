#!/bin/bash


set -x

for c_file in *.c
do
   gcc "$c_file"
done
