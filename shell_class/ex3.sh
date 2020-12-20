#!/bin/bash

//if ls fred.c 2>/dev/null
if test -r fred.c
then
   if  gcc fred.c
   then
       ./a.out
   fi
else
   echo Qiwen write fred.c
fi
