#!/bin/bash

for sample in *.bam  

do  
   echo $sample  
   describer=$(echo ${sample} | sed 's/.bam//')  
   echo $describer  

   # Read names Sorting of BAM file  
   
   samtools sort -o name_sorted/${describer}.Nsorted.bam -O bam -n -@ 14 ${describer}.bam


    # Fixmate of Read names Sorted BAM file 

    samtools fixmate  name_sorted/${describer}.Nsorted.bam -@ 14  fixmate/${describer}.fixmate.bam


    # Sorting of BAM file  by chromosomal positions 

      samtools sort -@ 14 fixmate/${describer}.fixmate.bam  -o CP_sorted/${describer}.CPsorted.bam 

    # index the bam file  
  
       samtools index -@ 14 CP_sorted/${describer}.CPsorted.bam  

done

