#include <stdio.h>
#include <stdlib.h>
#include <time.h>


void escribirCSV(int n, float *v1, float *v2, float *vr) 
{ 
  FILE *f = fopen("Vectores.csv", "w"); 

  for(int i=0; i<n-1; i++)
  	fprintf(f, "%f,", v1[i]);
  fprintf(f, "%f\n", v1[n-1]);

  for(int i=0; i<n-1; i++)
  	fprintf(f, "%f,", v2[i]);
  fprintf(f, "%f\n", v2[n-1]);

  for(int i=0; i<n-1; i++)
  	fprintf(f, "%f,", vr[i]);
  fprintf(f, "%f", vr[n-1]);

  fclose(f); 
} 

float* SumarVectores(float *v1, float *v2, int n){

	float* vr;
	vr = (float*)malloc(n*sizeof(float));

	for(int i=0; i<n; i++){
		vr[i] = v1[i]+v2[i]; 
	}
	return vr;
}

void llenarVectores(){

	int n;
	float* v1;
	float* v2;
	float* vr;

	/*printf("Ingrese la longitud de los vectores: ");
	scanf("%d",&n);*/
	n = 1000000;

	v1 = (float*)malloc(n*sizeof(float));
	v2 = (float*)malloc(n*sizeof(float));

	srand(time(NULL));
	for(int i=0; i<n; i++){
		v1[i] = rand(); 
	}

	for(int i=0; i<n; i++){
		v2[i] = rand(); 
	}

	/*printf("vector 1: ----------------------\n"); 

	for(int i=0; i<n; i++){
		printf("%f ", v1[i]); 
	}	

	printf("\nvector 2: ----------------------\n"); 

	for(int i=0; i<n; i++){
		printf("%f ", v2[i]); 
	}	

	printf("\nvector 1 + vector 2: ----------------------\n");*/
	vr = SumarVectores(v1, v2, n);
	/*for(int i=0; i<n; i++){
		printf("%f ", vr[i]); 
	}
	printf("\n");*/
	escribirCSV(n, v1, v2, vr);
	free(v1);
	free(v2);
	free(vr);
}





int main()
{
	clock_t t_ini, t_fin;
  	double secs;

  	t_ini = clock();
	llenarVectores();
	t_fin = clock();

  	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  	printf("Tiempo de ejecución: %.16g milisegundos\n", secs * 1000.0);
	return 0;
}
