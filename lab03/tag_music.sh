#!/bin/sh

for directory in "$@"
do
    current=`pwd`
    cd "$directory"
    for file in *
    do
        #if test "$file" = "*"
        #then
        #    break
            #fi
        track=`echo "$file" | cut -d' ' -f1`
        title=`echo "$file" | sed -r 's/^.*?- (.*?) -.*?$/\1/'`
        artist=`echo "$file" | sed 's/^.*- //;s/\.mp3//'`
                path=`pwd`
        album=`echo "$path" | sed 's/^.*\///'`
        year=`echo "$album" | cut -d',' -f2 | sed 's/^ //'`
                id3 -T "$track" "$file" >/dev/null
        id3 -t "$title" "$file" >/dev/null
        id3 -a "$artist" "$file" >/dev/null
        id3 -A "$album" "$file" >/dev/null
        id3 -y "$year" "$file" >/dev/null
    done
    cd $current
done
