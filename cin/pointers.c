#include <stdio.h>

int main(int argc, char *argv[])
{
    int a, b, c;
    int *p;
    // declare a pointer variable and assign it to address of e.g. a
    a = 666;
    p = &a;
    printf("p = %d\n", *p);
    // Evaluate expressions using both the original and the pointer variable
    // and investigate the value / value pointed to


    return 0;
}
