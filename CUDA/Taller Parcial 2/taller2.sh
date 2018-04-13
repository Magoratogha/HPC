#!/bin/bash

#SBATCH --job-name=matrixmul
#SBATCH --output=matrixmul.out

module load cuda42/toolkit
./out input.txt
sleep 60
