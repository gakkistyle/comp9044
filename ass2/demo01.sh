#!/bin/dash

# this is from lector notes repeat_message.sh
# written by andrewt@cse.unsw.edu.au as a COMP2041|COMP9044 example
# demonstrate simple use ofa shell function

repeat_message() {
    n=$1
    message=$2
    local i
    i=0
    while test $i -lt $n
    do
        echo "$i: $message"
        i=$((i + 1))
    done
}

i=0
while test $i -lt 4
do
    repeat_message 3 "helloAndrew" 
    i=$((i + 1))
done
