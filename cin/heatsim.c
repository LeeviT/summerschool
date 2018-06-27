#include <stdio.h>
#include <stdlib.h>

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

int main(void)
{
    int i, j;
    double array[NX][NY] = {};
    temp_field temp_field1 = default_scalar_field;

    printf("%d %d %d\n", temp_field1.nx, temp_field1.ny, temp_field1.n);
    printf("%f\n", temp_field1.field_data[187][187]);

    init_field_matrix(&temp_field1);

    printf("%f", temp_field1.field_data[0][0]);
   
    laplacian(&temp_field1);
 
    return 0;
}
