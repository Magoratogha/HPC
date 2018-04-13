#!/bin/bash

#SBATCH --job-name=matrixmul
#SBATCH --output=matrixmul.out
#SBATCH -p defq

module load cuda42/toolkit
./out input.txt
sleep 60
