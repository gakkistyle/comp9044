#!/bin/sh

cd test
for file in *
do
   wcline=`wc -l <$file|sed 's/[^0-9]//g'`
   if test $wcline -lt 10
   then
   	   small_size="$small_size $file"
   elif test $wcline -lt 100
   then
   	   medium_size="$medium_size $file"
   else
   	   large_size="$large_size $file"
   fi
done

echo "Small files:$small_size"
echo "Medium-sized files:$medium_size"
echo "Large files:$large_size"