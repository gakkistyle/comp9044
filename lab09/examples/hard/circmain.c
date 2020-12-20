/* circmain.c - main program incorporating two circular dependencies.
 *
 * make can cope with circular deps
 * (it tells you it's ignoring one or more rules).
 * Can your makefile generator manage?
 */

#include "circ1.h"

int main(void)
{
    return 0;
}
