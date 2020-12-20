#!/bin/sh

cat >main.c<<'eof'
#include <stdio.h>

int main(void){
	int v = 0;
eof

i=0
while test $i -lt 1000
do
	cat >>main.c<<eof
	int f$i(void);
	v += f$i();
eof
    
    cat >file$i.c<eof
    int f$i(void){
    	return $i;
    }
    eof

    i=$((i + 1))
done

cat >>main.c<<'eof'
    printf("%d\n",v);
    return 0;
}
eof

time clang main.c file*.c
./a.out