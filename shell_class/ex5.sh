#!/bin/sh

set -x

for arg in "$@"
do
    echo "$arg" has $(wc -l <"$arg") lines
done
