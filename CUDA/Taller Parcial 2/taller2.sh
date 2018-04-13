#!/bin/bash

#SBATCH --job-name=matrixmul
#SBATCH --output=matrixmul.out
#
#SBATCH --nodes=1
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=100

./out input.txt
sleep 60
