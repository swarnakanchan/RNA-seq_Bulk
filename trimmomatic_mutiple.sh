#!/bin/bash


for infile in *_R1_001.fastq.gz

do
base=$(basename ${infile} _R1_001.fastq.gz) 
trimmomatic PE  -threads 14 -phred33 ${infile} ${base}_R2_001.fastq.gz \
${base}_R1.trim.fastq.gz ${base}_R1.un.trim.fastq.gz \
${base}_R2.trim.fastq.gz ${base}_R2.un.trim.fastq.gz \
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 HEADCROP:3 SLIDINGWINDOW: 4:15 MINLEN:25 \
2>trim_log.txt
done
