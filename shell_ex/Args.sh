#!/bin/bash

echo My name is $0
echo My process number is $$
echo I have $# arguments
echo My arguments separately are $*
echo My arguments together are "$@"
if test $5 
then 
   echo My 5th arguments is "$5"
else
   echo My 5th argumetns is "''"
fi