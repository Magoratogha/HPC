#!/bin/bash
#
#SBATCH --job-name=MulMatrix
#SBATCH --output=res_MulMatrix.out
#SBATCH --ntasks=1
#SBATCH --nodes=3
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=500

./out input.txt