#include <stdio.h>
#include <stdlib.h>
#include "heat_funcs.c"
#include "heat.c"

#define NX 258
#define NY 258

struct scalar_field {
       int nx;
       int ny;
       int n;
       double dx;
       double dy;
       double dx2;
       double dy2;
       double field_data[NX][NY];
} default_scalar_field = {NX-2, NY-2, (NX-2)*(NY-2), 0.01, 0.01,
                          0.01*0.01, 0.01*0.01, {}};

typedef struct scalar_field temp_field;

void init_field_matrix(temp_field *f);

void laplacian(temp_field *f);
