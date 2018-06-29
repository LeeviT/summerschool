#include <stdio.h>
#include <stdlib.h>
#include "heatsim.h"

void init_field_matrix(temp_field *f) {
    int i;
    for (i=0; i<NX; i++) {
       f->field_data[i][0] = 20.0;
       f->field_data[0][i] = 85.0;
       f->field_data[i][NX-1] = 70.0;
       f->field_data[NY-1][i] = 5.0;
    }
}

void laplacian(temp_field *f) {
    int i, j;
    double lap_f[NX][NY];

    for (i=1; i<NX-1; i++) {
       for (j=1; j<NY-1; j++) {
          lap_f[i][j] = ((*f).field_data[i-1][j] - 
          2*((*f).field_data[i][j]) + (*f).field_data[i+1][j])/(0.01*0.01) + 
          ((*f).field_data[i][j-1] - 2*((*f).field_data[i][j]) + 
          (*f).field_data[i][j+1])/(0.01*0.01);
       }
    }
    for (i=1; i<NX; i++) {
       for (j=1; j<NY; j++) {
          f->field_data[i][j] = lap_f[i][j];
       }
    }
} 
