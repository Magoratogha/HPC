#!/bin/bash

#SBATCH --job-name=MatrixMul
#SBATCH --output=MatrixMul.out
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gres=gpu:1

export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64/${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export CUDA_VISIBLE_DEVICES=0

./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt
rm outputSecuencial.txt
./out1 input.txt

./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt
rm outputIngenuo.txt
./out2 input.txt

./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
rm outputSH.txt
./out3 input.txt
