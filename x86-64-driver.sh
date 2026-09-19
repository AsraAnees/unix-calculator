#!/usr/bin/env bash

if [ $# -le 0 ]; then
	echo "Please Provide a filename as an argument"
	exit
fi

calc_file_name=$1

if [[ $calc_file_name = "fact.calc" || $calc_file_name = "gcd.calc" || $calc_file_name = "looptest.calc" || $calc_file_name = "pi.calc" || $calc_file_name = "harmonic.calc" ]]
then

  calc_file_name_cut="$(basename "${calc_file_name}" .calc)"

  
  # Preparing the data,text,global and main section
 
  echo ".data" > src/${calc_file_name_cut}.s
  echo "" >> src/${calc_file_name_cut}.s
  echo ".text" >> src/${calc_file_name_cut}.s
  echo ".global main" >> src/${calc_file_name_cut}.s
  echo "main:" >> src/${calc_file_name_cut}.s

  # Running calc3i.bin by passing entered file assembly structure
  
  cat "${calc_file_name}" | ./bin/calc3i.bin >> src/${calc_file_name_cut}.s

  # To exit the control using system call
  echo -e '\tmovq    \t$60, \t%rax' >> src/${calc_file_name_cut}.s
  echo -e '\tmovq    \t$1, \t%rbx' >> src/${calc_file_name_cut}.s
  echo -e '\tsyscall\n' >> src/${calc_file_name_cut}.s

  # Command to create the executable of the passing .calc file
  gcc -c src/${calc_file_name_cut}.s -o obj/${calc_file_name_cut}.o; gcc -static obj/${calc_file_name_cut}.o -L ./lib/ -l my_lib -o bin/${calc_file_name_cut}.bin

else
  echo "The provided filename is not correct"
  exit
fi
