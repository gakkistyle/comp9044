#!/bin/sh

cnt=0
flag=0
if test "$#" -eq 2
then
    if ! test -d "$2"
    then
        mkdir "$2"
    fi
    cd "$2"
    wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw' |
    while read line
    do
        if test $cnt -gt 0
        then
            # flag set, parse the page
            song=`echo "$line" | egrep '^#'`
            if ! test "$song" = ""
            then
                
                artist=`echo "$line" | sed -r -e 's/\xE2\x80\x93.*?$//;s/\[\[[^]]*?\|([^]]*?)]]/\1/g;s/]//g;s/\[//g;s/^#//;s/^ *//;s/ *$//'`
                
                songname=`echo "$line" | sed -r -e 's/^.*?\xE2\x80\x93//;s/\[\[[^]]*?\|([^]]*?)]]/\1/g;s/]//g;s/\[//g;s#/#-#g;s/"//g;s/^ *//;s/ *$//'`
                new_filename="$cnt - $songname - $artist.mp3"
                cnt=$(( $cnt + 1 ))
                cp "../../$1" "$new_filename"
            fi
            if test "$cnt" -eq 11
            then
                cnt=0
                cd ..
            fi


        else
            # flag not set, parse the album
            album=`echo "$line" | egrep '.*style.*Triple J Hottest 100, [0-9]{4}\|[0-9]{4}' |egrep -o 'Triple J Hottest 100, [0-9]{4}'`
            if ! test "$album" = ""
            then
                cnt=1
                mkdir "$album"
                cd "$album"
            fi
        fi
        #year=`echo "$album" | cut -d, -f2 | sed 's/^ *//'`
    done
fi
