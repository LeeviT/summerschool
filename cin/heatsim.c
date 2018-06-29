#include <stdio.h>
#include <stdlib.h>
#include "heatsim.h"
#include "pngwriter.h"

int main(void)
{
    int i, j;
    double png_data[NX*NY];
    double lap_field[(NX-2)*(NY-2)];
    temp_field temp_field1 = {NX-2, NY-2, (NX-2)*(NY-2), 0.01, 0.01,
                              0.01*0.01, 0.01*0.01, {}};

    printf("%d %d %d\n", temp_field1.nx, temp_field1.ny, temp_field1.n);
    printf("%f\n", temp_field1.field_data[187][187]);

    init_field_matrix(&temp_field1);

    printf("%f\n", temp_field1.field_data[0][0]);
   
    laplacian(&temp_field1);
    
    for (i=0; i<NX; i++) {
       for (j=0; j<NY; j++) {
          png_data[NX*i+j] = temp_field1.field_data[i][j];
       }
    }

    save_png(png_data, NX, NY, "heat.png", 'c');
 
    return 0;
}
