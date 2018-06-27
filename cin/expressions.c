#include <stdio.h>

int main(int argc, char *argv[])
{
    int a=1;
    long b=100;
    float c=3.14;
    double d=6.38402;
    // declare integers, floats, and doubles
    
    a += b;
    printf("a + b = %d\n", a);
    printf("d = %.3f", d);
    // evaluate expressions, e.g. c = a + 2.5 * b
    // and print out results. Try to combine integers, floats
    // and doubles and investigate what happens in type conversions

    return 0;
}
