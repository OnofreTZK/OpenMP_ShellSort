#!/bin/bash

#SBATCH --partition=cluster
#SBATCH --job-name=shellSort110
#SBATCH --output=shellSort110.out
#SBATCH --error=shellSortError110.err
#SBATCH --time=0-15:0
#SBATCH --hint=compute_bound 
#SBATCH --mail-user=onofret7@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32

#No Supercomputador, 1 nó = 32 Cores (ou CPUs)
#Lembrar que: TASK = PROCESSO

#A configuração acima reserva 1 nó inteiro (32 cpus no mesmo processador), vai rodar apenas 1 processo por vez,
# mas este processo terá acesso a 32 cores

#Loop principal de execuções. São 10 tentativas

module load compilers/gnu/8.3
g++ -g -Wall -fopenmp -std=c++0x shellsort_prl.cpp -o shell

	tentativas=10 #Quantas vezes o código será executado

	for cores in 4 8 16 32 #números de cores utilizados
	do
			for size in 110000000 #tamanho do problema
			do   	
				echo -e "\n$cores\t$size\t\t" >> "parallel_110_core.txt" 

				for tentativa in $(seq $tentativas) #Cria uma vetor de 1 a "tentativas"
				do
					./shell $cores $size >> "parallel_110_time.txt"
				done
			done

	done
	
	exit 
