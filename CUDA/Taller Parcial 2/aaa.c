#include <stdio.h>
#include <stdlib.h>

void LeerMatriz(float* m1, float* m2, FILE* file, int fil1, int fil2, int col1, int col2){
	
	for(int i=0; i<fil1*col1; i++){
		fscanf(file, "%f", &m1[i]);
    }

	for(int i=0; i<fil2*col2; i++){
		fscanf(file, "%f", &m2[i]);
    }

	fclose(file);
}


int main()
{
	float *m1, *m2;
	int fil1, fil2, col1, col2;

    FILE *archivo;
	archivo = fopen("input.txt", "r");
    fscanf(archivo, "%d %d", &fil1, &col1);
    fscanf(archivo, "%d %d", &fil2, &col2);

    printf("%d ",fil1);
    printf("%d ",col1);
    printf("%d ",fil2);
    printf("%d ",col2);

    m1 = (float*)malloc(fil1 * col1 * sizeof(float));
    m2 = (float*)malloc(fil2 * col2 * sizeof(float));

    LeerMatriz(m1, m2, archivo, fil1, fil2, col1, col2);

    printf("-----------MATRIX1 ------------- \n");
    for(int i=0; i<fil2; i++){
        for(int j=0; j<col2; j++){
            printf("%f ", m2[i * col2 + j]);
        }
        printf("\n");
    }

    printf("-----------MATRIX1 ------------- \n");
    for(int i=0; i<fil1; i++){
        for(int j=0; j<col1; j++){
            printf("%f ", m1[i * col1 + j]);
        }
        printf("\n");
    }

    /*printf("-----------MATRIX2 ------------- \n");
    for(int i=0; i<fil2; i++){
        for(int j=0; j<col2; j++){
            printf("%f ", m2[i * col2 + j]);
        }
        printf("\n");
    }*/	

	return 0;
}