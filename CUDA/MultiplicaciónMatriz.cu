#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>

__global__ void MulMatriz(float *min, float *mout, int fil, int col)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
	if(id < fil*col) 
		mout[id] = min[id]*5; 
}


int main()
{
	//Inicia reloj ------------------------
	clock_t t_ini, t_fin;
  	double secs;
  	t_ini = clock();
  	//-------------------------------------

	int fil, col;
	float *h_min, *h_mout;
	float *d_min, *d_mout;

	fil = 3;
	col = 4; //con el más grande se hace la referencia para la matriz en 1D

	int size = fil*col*sizeof(float); //tamaño en bits de cada matriz

	h_min = (float*)malloc(size);
	h_mout = (float*)malloc(size);
	cudaMalloc(&d_min, size);
    cudaMalloc(&d_mout, size);

	//Iniciar matriz con valor 13------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			h_min[i*col+j] = 13; 
		}
	}

	//Imprimir resultados------------------
	printf("matriz: ----------------------\n"); 
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_min[i*col+j]);
		}
		printf("\n"); 
	}	

	printf("\nmatriz x5: ----------------------\n"); 

	cudaMemcpy(d_min, h_min, size, cudaMemcpyHostToDevice);
	MulMatriz<<<ceil(fil*col/256.0),256>>>(d_min, d_mout, fil, col); //Ejecución del kernel
	cudaMemcpy(h_mout, d_mout, size, cudaMemcpyDeviceToHost); //Copia de datos al host
	
	//Imprimir resultados------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_mout[i*fil+j]);
		}
		printf("\n"); 
	}
	//-------------------------------------

	cudaFree(d_min);
    cudaFree(d_mout);
	free(h_min);
	free(h_mout);

	//Fin reloj ------------------------
  	t_fin = clock();
  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecucion: %.16g milisegundos\n", secs * 1000.0);
  	
  	return 0;
}
