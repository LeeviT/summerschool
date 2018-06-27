#include <stdio.h>

int main() {
   
   int a;
   a = 1000;

   if (a < 0) {
      printf("a is negative\n");
   } else if (a == 0) {
      printf("a is zero\n");
   } else if (a > 100) {
      printf("a is larger than 100\n");
   }
   return 0;
}
