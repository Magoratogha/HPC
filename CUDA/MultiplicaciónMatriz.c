#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>

__global__
void MulMatriz(float *h_m, int fil, int col, int n){

	int i = threadIdx.x + blockDim.x * blockDimIdx.x;
	if(i<fil*col){
		d_m[i]=d_m[i]*n;
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
	float* h_m;

	fil = 3;
	col = 4; //con el más grande se hace la referencia para la matriz en 1D

	h_m = (float *)malloc (fil*col*sizeof(float *)); //Reserva de memoria en el host

	//Iniciar matriz con valor 13------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			h_m[i*col+j] = 13; 
		}
	}

	//Imprimir resultados------------------
	printf("matriz: ----------------------\n"); 

	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_m[i*col+j]);
		}
		printf("\n"); 
	}	

	printf("\nmatriz x5: ----------------------\n"); 

	//Reserva y copia de datos al dispositivo ---------
	int size = fil*col*sizeof(float)
	float* d_m;
	cudaMalloc((void **) &d_m, size);
	cudaMemcpy(d_m, h_m, size, cudaMemcpyHostToDevice);
	//-------------------------------------------------

	MulMatriz<<<ceil(fil*col/256.0),256>>>(d_m, fil, col, 5); //Ejecución del kernel

	cudaMemcpy(h_m, d_m, size, cudaMemcpyDeviceToHost); //Copia de datos al host
	cudaFree(d_m); //Liberar memoria del dispositivo

	//Imprimir resultados------------------
	for(int i=0; i<fil; i++){
		for(int j=0; j<col; j++){
			printf("%f ", h_m[i*fil+j]);
		}
		printf("\n"); 
	}
	//-------------------------------------

	free(h_m);//Liberar memoria host

	//Fin reloj ------------------------
  	t_fin = clock();
  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecucion: %.16g milisegundos\n", secs * 1000.0);
  	
  	return 0;
}
