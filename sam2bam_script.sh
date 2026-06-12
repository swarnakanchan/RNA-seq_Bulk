#!/bin/bash

for sample in *.sam  

do  
   echo $sample  
   describer=$(echo ${sample} | sed 's/.sam//')  
   echo $describer  

   
   samtools view -@ 32 -bS -o bam_files/${describer}.bam  ${describer}.sam

   done
