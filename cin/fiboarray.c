#include <stdio.h>

int main() {
   unsigned long long fn1, fn2, fn3, i, a[20];

   fn1 = 0;
   fn2 = 1;
   i = 0;
     
   a[0] = fn1;
   a[1] = fn2;

   for (i=2; i<19; i++) {
      fn3 = fn1+fn2;
      a[i] = fn3;
      printf("%llu\n", a[i]);
      fn1 = fn2;
      fn2 = fn3;
   }
}

