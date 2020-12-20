/* main.c */

#include <stdio.h>

#include "c.h"
#include "a.h"
#include "b.h"

int main(int argc, char *argv[])
{
    printf("Hello, I'm main\n");
    a();
    b();
    c();
    return 0;
}
