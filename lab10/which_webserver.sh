#!/bin/sh

for web in $@
do
	echo -n "$web "
	curl -s -I $web|egrep -i ^server|cut -d' ' -f2-

done