#!/bin/bash

#bash script for hisat2; align all .fastq.gz files to indexed reference genome to generate .sam files

SAMPLES="H460-Control-S1 H460-Control-S2 H460-Control-S3 H460-Control-S4 H460-Control-S5 H460-FLLL22-S6 H460-FLLL22-S7 H460-FLLL22-S8 H460-FLLL22-S9 H460-FLLL22-S10 "

for SAMPLE in $SAMPLES; 

do
   

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 ${SAMPLE}_R1.trim.fastq.gz -2 ${SAMPLE}_R2.trim.fastq.gz -S ${SAMPLE}.sam 2>${SAMPLE}_align.log

done