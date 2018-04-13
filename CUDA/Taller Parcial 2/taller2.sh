#!/bin/bash
#
#SBATCH --job-name=MulMatrix
#SBATCH --output=res_MulMatrix.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=100

./out input.txt