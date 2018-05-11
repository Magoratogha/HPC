# Taller Parcial 2
High Performance Computing. 

**Realizado por:** Santiago Gómez Grajales - Juan Pablo Tabares Rico. UTP, 2018

## Enunciado:

1. A partir de la construcción de la primera parte del Parcial 2 se deberá construir un programa que haga uso de Memoria Compartida, como se vió en clase.
2. Se deberán presentar gráficas comparativas de tiempos de ejecución entre los algoritmos, sin aceleración, la implementación ingenua y la implementación con memoria compartida.
3. Deberán existir gráficas comparativas de aceleración de la implementación ingenua y la implementación con memoria compartida con respecto a la implementación sin aceleración.
4. Deberán entregarse conclusiones puntuales sobre las tendencias que se obtienen de acuerdo a las gráficas. Deben ser conclusiones profesionales. **OJO**.
5. El proyecto como tal deberá estar albergado en un repositorio (Github, Gitlab, Bitbucket, ... entre otros). Se deberá hacer uso de Markdown para mostrar los resultados y el reporte de este proceso.
6. Este proceso pueden hacer en grupos. Ojalá los mismos que van a presentar el proyecto final.
7. La calificación se hará seleccionando **(El profesor lo seleccionará)** uno de los integrantes del grupo para que explique todo el proceso.
8. Todas las implementaciones deberán hacerse a través de **SLURM​.**
9. Sino se usa **SLURM​,** se tendrá una nota de 0.0.
10. Se tendrá en cuenta la fluidez a la hora de usar la consola, conectarse al clúster y conocer toda la infraestructura que están usando.
11. Tengan en cuenta investigar todo sobre las características de las GPU que contiene el clúster.
12. Todas las implementaciones deberán ejecutarse mínimo 10 veces para garantizar un tiempo y cálculo de aceleración promedio que servirá como insumo para la construcción de las gráficas.
13. El resultado de esta implementación debe mostrar una aceleración del algoritmo.
14. El algoritmo debe multiplicar bien. **SÚPER IMPORTANTE.**


## Implementación:

Para la construcción de este taller se realizaron 3 implementaciones diferentes de un mismo algoritmo para la multiplicación de dos matrices, estos algoritmos fueron:

- MulMat_V1.c [Versión sin optimizar, algoritmo secuencial]
- MulMat_V2.cu [Versión paralela optimizada con CUDA, algoritmo ingenuo]
- MulMat_V3.cu [Versión paralela optimizada con CUDA, algoritmo haciendo uso de memoria compartida]

Y se usaron también, 3 tipos de entradas diferentes:

- input-short.txt [2 Matrices de 400x400]
- input-medium.txt [2 Matrices de 1000x1000]
- input-long.txt [2 Matrices de 2000x2000]


## CPU's y GPU's:

Los algoritmos fueron probados y ejecutados en un clúster a través de la herramienta **SLURM** solicitando **1GB** de memoria RAM y un único nodo, con las siguientes especificaciones:

### CPU:

**Intel Core i7-4790K:**

- Cantidad de núcleos: 4
- Cantidad de subprocesos: 8
- Frecuencia máxima del procesador: 4,40 GHz
- Cache L2: 1 MB
- Cache L3: 8 MB

### GPUs

**Nvidia GTX 980**

- Memoria: 4096 MB GDDR5
- SMs: 16
- CUDA Cores: 2048
- Frecuencia máxima: 1216 MHz
- Floating-point performance: 4981 GFLOPs
- Memory Clock: 7000 MHz
- Memory Bandwidth: 224 GB/sec
- L2 Cache: 2048KB
- Manufacturing Process: 28-nm

**Nvidia GTX 780**

- Memoria: 3072 MB GDDR5
- SMs: 12
- CUDA Cores: 2304
- Frecuencia máxima: 900 MHz
- Floating-point performance: 3977 GFLOPs
- Memory Clock: 6000 MHz
- Memory Bandwidth: 288 GB/sec
- L2 Cache: 1536KB
- Manufacturing Process: 28-nm

Las implementaciones realizadas, se ejecutaron de manera independiente en cada GPU. Se realizaron en total 10 ejecuciones por cada prueba y en las gráficas se evidencia el valor promedio de los resultados.


## Análisis de los resultados:

### Ejecución en GTX 980 vs CPU
#### Input Short (Tiempo en milisegundos)
![Input Short](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/980short.jpeg)
#### Input Medium (Tiempo en milisegundos)
![Input Medium](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/980medium.jpeg)
#### Input Long (Tiempo en milisegundos)
![Input Long](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/980long.jpeg)

### Ejecución en GTX 780 vs CPU
#### Input Short
![Input Short](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/780short.jpeg)
#### Input Medium
![Input Medium](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/780medium.jpeg)
#### Input Long
![Input Long](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/780long.jpeg)

### Comparativa GTX980 y GTX780 frente a la CPU:
#### Rendimiento general GTX980
![Input Long](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/980vsCPU.PNG)
#### Rendimiento general GTX780
![Input Long](https://raw.githubusercontent.com/Magoratogha/HPC/master/CUDA/Taller%20Parcial%202/Files/780vsCPU.PNG)


## Conclusiones:
- El aceleramiento es más evidente cuando se requiere más procesamiento de los datos, esto podemos apreciarlo en las gráficas cuando comparamos los datos de entrada. A medida que el input aumenta su tamaño, el salto entre los tiempos de CPU y GPU es más notorio.
- En terminos de porcentajes, la aceleración general fue:
1. Con un Input Short: Ingenuo (**45,82%**), SH (**52,26%**)
2. Con un Input Medium: Ingenuo (**75,51%**), SH (**79,7%**)
3. Con un Input Long: Ingenuo (**86,61%**), SH (**89,69%**)
- Cuando comparamos el rendimiento de las GPUs, vemos que la GTX980 es superior a la GTX780. Aunque hay características que sobresalen tanto en una como en la otra, la característica que más influye en el rendimiento es el número de Stream Multiprocessors, debido a que si se tiene un número mayor de SM se tiene más memoria compartida diponible para el cómputo.
- Si comparamos el algoritmo ingenuo contra el que hace uso de la memoria compartida, podemos ver que la diferencia entre ambos radica principalmente en la cantidad de memoria compartida que se tenga disponible a la hora del cómputo. Como ejemplo, vemos que la GTX980 al tener una mayor disponibilidad en memoria compartida realiza una optimización más notoria que la GTX780 cuando se ejecuta el algoritmo de memoria compartida frente al ingenuo.
