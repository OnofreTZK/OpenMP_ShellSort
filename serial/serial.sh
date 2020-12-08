#!/bin/bash

#SBATCH --partition=cluster
#SBATCH --job-name=shellSort
#SBATCH --output=shellSort.out
#SBATCH --error=shellSortError.err
#SBATCH --time=0-04:0
#SBATCH --hint=compute_bound 

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1

#No Supercomputador, 1 nó = 32 Cores (ou CPUs)
#Lembrar que: TASK = PROCESSO

#A configuração acima reserva 1 nó inteiro (32 cpus no mesmo processador), vai rodar apenas 1 processo por vez,
# mas este processo terá acesso a 32 cores

#Loop principal de execuções. São 10 tentativas

g++ -g -Wall -std=c++11 shellsort_serial.cpp -o shell

	tentativas=10 #Quantas vezes o código será executado

	for cores in 1 #números de cores utilizados
	do
			for size in 1000000000 2000000000 #tamanho do problema
			do   	
				echo -e "\n$size\t\t\c" >> "serial_time.txt" 

				for tentativa in $(seq $tentativas) #Cria uma vetor de 1 a "tentativas"
				do
					./shell $size #
				done
			done

	done
	
	exit 

