#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void MulMatriz(float **m, int fil, int col, int n){

	for(int i=0; i<fil; i++){
    	for(int j=0; j<col; j++){
        	m[i][j]=m[i][j]*n;
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
	float** m;

	fil = 5;
	col = 6;

	m = (float **)malloc (fil*sizeof(float *));
	for (int i=0; i<fil; i++)
		m[i] = (float *) malloc (col*sizeof(float));

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			m[i][j] = 13; 
		}
	}

	printf("matriz: ----------------------\n"); 

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", m[i][j]);
		}
		printf("\n"); 
	}	

	printf("\nmatriz x5: ----------------------\n");

	MulMatriz(m, fil, col, 5);

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", m[i][j]);
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
