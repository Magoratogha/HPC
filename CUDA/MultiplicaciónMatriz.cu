#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>
#include <cuda_runtime.h>

__global__
void MulMatriz(float *d_m, int fil, int col, int n)
{
	int i = threadIdx.x + blockDim.x * blockIdx.x;
	if(i<fil*col) d_m[i] = d_m[i]*n; 
}


int main()
{
	//Inicia reloj ------------------------
	clock_t t_ini, t_fin;
  	double secs;
  	t_ini = clock();
  	//-------------------------------------

	int fil, col;
	float* h_in, h_out;
	float* d_m;

	fil = 3;
	col = 4; //con el más grande se hace la referencia para la matriz en 1D

	h_in = (float *)malloc (fil*col*sizeof(float *)); //Reserva de memoria en el host
	h_out = (float *)malloc (fil*col*sizeof(float *));

	//Iniciar matriz con valor 13------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			h_in[i*col+j] = 13; 
		}
	}

	//Imprimir resultados------------------
	printf("matriz: ----------------------\n"); 

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_in[i*col+j]);
		}
		printf("\n"); 
	}	

	printf("\nmatriz x5: ----------------------\n"); 

	//Reserva y copia de datos al dispositivo ---------
	int size = fil*col*sizeof(float);
	cudaMalloc((void **) &d_m, size);
	cudaMemcpy(d_m, h_in, size, cudaMemcpyHostToDevice);
	//-------------------------------------------------

	MulMatriz<<<ceil(fil*col/256.0),256>>>(d_m, fil, col, 5); //Ejecución del kernel

	cudaMemcpy(h_out, d_m, size, cudaMemcpyDeviceToHost); //Copia de datos al host
	//Liberar memoria del dispositivo

	//Imprimir resultados------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_out[i*fil+j]);
		}
		printf("\n"); 
	}
	//-------------------------------------
	cudaFree(d_m);
	free(h_in);
	free(h_out);//Liberar memoria host

	//Fin reloj ------------------------
  	t_fin = clock();
  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecucion: %.16g milisegundos\n", secs * 1000.0);
  	
  	return 0;
}
