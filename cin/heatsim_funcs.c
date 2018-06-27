#include <stdio.h>
#include <stdlib.h>
#include "heat.h"

#define NX 258
#define NY 258

void init_field_matrix(temp_field *field1) {
    int i;
    for (i=0; i<NX; i++) {
       field1->field_data[i][0] = 20.0;
       field1->field_data[0][i] = 85.0;
       field1->field_data[i][NX-1] = 70.0;
       field1->field_data[NY-1][i] = 5.0;
    }
}

void laplacian(temp_field *field1) {
    int i, j;
    for (i=1; i<NX-1; i++) {
       for (j=1; j<NY-1; j++) {
          field1->field_data[i][j] = ((*field1).field_data[i-1][j] - 
          2*(*field1).field_data[i][j] + (*field1).field_data[i+1][j])/(0.01*0.01) + 
          ((*field1).field_data[i][j-1] - 2*(*field1).field_data[i][j] + 
          (*field1).field_data[i][j+1])/(0.01*0.01);
       }
    }
} 
