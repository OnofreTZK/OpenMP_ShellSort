#!/bin/bash

#SBATCH --partition=cluster
#SBATCH --job-name=shellSort60
#SBATCH --output=shellSort60.out
#SBATCH --error=shellSortError60.err
#SBATCH --time=0-06:0
#SBATCH --hint=compute_bound 
#SBATCH --mail-user=onofret7@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1

#No Supercomputador, 1 nó = 32 Cores (ou CPUs)
#Lembrar que: TASK = PROCESSO

#A configuração acima reserva 1 nó inteiro (32 cpus no mesmo processador), vai rodar apenas 1 processo por vez,
# mas este processo terá acesso a 32 cores

#Loop principal de execuções. São 10 tentativas

module load compilers/gnu/8.3
g++ -g -Wall -std=c++0x shellsort_serial.cpp -o shell

	tentativas=10 #Quantas vezes o código será executado

	for cores in 1 #números de cores utilizados
	do
			for size in 60000000 #tamanho do problema
			do   	
				echo -e "\n$size\t\t" >> "serial_60_core.txt" 

				for tentativa in $(seq $tentativas) #Cria uma vetor de 1 a "tentativas"
				do
					./shell $size >> "serial_60_time.txt"
				done
			done

	done
	
	exit 
