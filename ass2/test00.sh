#!/bin/sh

#this is from lecture notes args.sh that I can not handle properly.

echo My name is $0
echo My process number is $$
echo I have $# arguments
echo My arguments separately are $*
echo My arguments together are "$@"
echo My 5th argument is "'$5'"