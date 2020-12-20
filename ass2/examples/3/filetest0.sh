#!/bin/dash
if test -r /dev/null
then
    echo a
fi
if test -r nonexistantfile
then
    echo b
fi
