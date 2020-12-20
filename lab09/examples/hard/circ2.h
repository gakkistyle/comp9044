/* circ2.h */

/* This is to prevent gcc from having a heart attack,
 * while still testing your program for mutual dependencies.
 */

#ifdef BAD
#include "circ1.h"
#endif
