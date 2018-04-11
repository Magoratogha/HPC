#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void MulMatriz(float *m, int fil, int col, int n){

	for(int i=0; i<fil; i++){
    	for(int j=0; j<col; j++){
        	m[i*col+j] = m[i*col+j]*n;
    	}
	}
}


int main()
{
	//Inicia reloj ------------------------
	clock_t t_ini, t_fin;
  	double secs;
  	t_ini = clock();
  	//-------------------------------------

	int fil, col;
	float* m;

	fil = 3;
	col = 4; //con el más grande se hace la referencia para la matriz en 1D

	m = (float *)malloc (fil*col*sizeof(float *));

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			m[i*col+j] = 13; 
		}
	}

	printf("matriz: ----------------------\n"); 

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", m[i*col+j]);
		}
		printf("\n"); 
	}	

	printf("\nmatriz x5: ----------------------\n");

	MulMatriz(m, fil, col, 5);

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", m[i*fil+j]);
		}
		printf("\n"); 
	}

	free(m);

	//Fin reloj ------------------------
  	t_fin = clock();
  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecucion: %.16g milisegundos\n", secs * 1000.0);
  	
  	return 0;
}
