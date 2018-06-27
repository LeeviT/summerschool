#include <stdio.h>

int main() {
   unsigned long long fn1, fn2, fn3, i;

   fn1 = 0;
   fn2 = 1;
   i = 0;
     
   printf("\t %d\n", fn1);
   printf("\t %d\n", fn2); 

   while (i<98) {
      fn3 = fn1+fn2;
      printf("%d \t %llu\n", i, fn3);
      fn1 = fn2;
      fn2 = fn3;
      i++;
   }
}

