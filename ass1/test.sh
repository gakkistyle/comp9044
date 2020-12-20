#!/bin/sh

ll=`diff shrug-add.sh shrug-add.sh`;
if [ "$ll" != "" ]
then
	echo "diff";
fi

all=$@
echo ${all[*]: -1};
