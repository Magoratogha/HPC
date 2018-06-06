#!/bin/bash

#SBATCH --job-name=Distmesh2D
#SBATCH --output=Distmesh.out
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1024

export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia-390


export CUDA_VISIBLE_DEVICES=0

echo Circulo 4 secuencial
python MainCirc4.py
python MainCirc4.py
echo Circulo 1 secuencial
python MainCirc1.py
python MainCirc1.py
echo Circulo 08 secuencial
python MainCirc08.py
python MainCirc08.py
echo cuadrado secuencial
python MainCuad.py
python MainCuad.py
echo annulus secuencial
python MainAnn.py
python MainAnn.py
echo star secuencial
python MainStar.py
python MainStar.py

echo Circulo 4 paralelizado
python MainCirc4CUDA.py
python MainCirc4CUDA.py
echo Circulo 1 paralelizado
python MainCirc1CUDA.py
python MainCirc1CUDA.py
echo Circulo 08 paralelizado
python MainCirc08CUDA.py
python MainCirc08CUDA.py
echo cuadrado paralelizado
python MainCuadCUDA.py
python MainCuadCUDA.py
echo annulus paralelizado
python MainAnnCUDA.py
python MainAnnCUDA.py
echo star paralelizado
python MainStarCUDA.py
python MainStarCUDA.py
