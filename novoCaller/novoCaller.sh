#first layer

./lustre/export/home/sylee/programfile/novoCaller/novoCaller \
-I <path to vcf file> \
-O <path to output file for layer 1> \
-T <path to file containing sample IDs of the trios, the IDs are in the order:parent1(TAB)parent2(TAB)proband> \
-X <put 1 if you want to run on X chromosome as well, 0 otherwise> \
-P <threshold on posterior probability. Calls are made if the PP is above threshold. Use a low value like 0.005 so that a large number of calls are made for the second layer> \
-E <threshold on the ExAC allele frequency, e.g. 0.0001>

#second layer

python -W ignore novoCallerBAM.py \  
-I <path to the output file from previous step (the file given in -O option)> \
-U <path to a file containing paths to the bam files from unrelated samples> \
-T <path to a file containing paths to the bam files of the trio> \
-O <path to the output file for the second layer>