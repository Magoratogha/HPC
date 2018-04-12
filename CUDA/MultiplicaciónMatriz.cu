#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>

__global__
void MulMatriz(float* d_min, float* d_mout, int fil, int col)
{
	int i = threadIdx.y + blockDim.y * blockIdx.y;
	int j= threadIdx.x + blockDim.x * blockIdx.x;

	if((i<fil)&&(j<col)) d_mout[i*col+j] = d_min[i*col+j]*5; 
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

	h_min = (float*)malloc (fil*col*sizeof(float)); //Reserva de memoria en el host
	h_mout = (float*)malloc (fil*col*sizeof(float));

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

	//Reserva y copia de datos al dispositivo ---------
	int size = fil*col*sizeof(float);
	int blockSize = 32;
    dim3 dimBlock(blockSize, blockSize, 1);
    dim3 dimGrid(ceil(col/float(blockSize)), ceil(fil/float(blockSize)), 1);
	
	cudaMalloc((void **) &d_min, size);
	cudaMalloc((void **) &d_mout, size);	
	cudaMemcpy(d_min, h_min, size, cudaMemcpyHostToDevice);
	//-------------------------------------------------

	MulMatriz<<<dimGrid,dimBlock>>>(d_min, d_mout, fil, col); //Ejecución del kernel

	cudaMemcpy(h_mout, d_mout, size, cudaMemcpyDeviceToHost); //Copia de datos al host

	//Imprimir resultados------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_mout[i*col+j]);
		}
		printf("\n"); 
	}
	//-------------------------------------
	cudaFree(d_min); //Liberar memoria del dispositivo
	cudaFree(d_mout);
	free(h_min);//Liberar memoria host
	free(h_mout);

	//Fin reloj ------------------------
  	t_fin = clock();
  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecucion: %.16g milisegundos\n", secs * 1000.0);
  	
  	return 0;
}
