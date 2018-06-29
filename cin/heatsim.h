#include <stdio.h>
#include <stdlib.h>

#define NX 258
#define NY 258

#ifndef STRUCTS
#define STRUCTS
typedef struct {
       int nx;
       int ny;
       int n;
       double dx;
       double dy;
       double dx2;
       double dy2;
       double field_data[NX][NY];
} temp_field;
#endif

#ifndef FUNCS
#define FUNCS
void init_field_matrix(temp_field *f);
void laplacian(temp_field *f);
#endif
