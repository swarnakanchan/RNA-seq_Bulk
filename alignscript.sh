#!/bin/bash

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-Control-S2_paired_R1.fastq.gz -2  H460-Control-S2_paired_R2.fastq.gz -S H460-Control-S2.sam 2>H460-Control-S2_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-Control-S3_paired_R1.fastq.gz -2  H460-Control-S3_paired_R2.fastq.gz -S H460-Control-S3.sam 2>H460-Control-S3_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-Control-S4_paired_R1.fastq.gz -2  H460-Control-S4_paired_R2.fastq.gz -S H460-Control-S4.sam 2>H460-Control-S4_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-Control-S5_paired_R1.fastq.gz -2  H460-Control-S5_paired_R2.fastq.gz -S H460-Control-S5.sam 2>H460-Control-S5_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-FLLL22-S6_paired_R1.fastq.gz -2  H460-FLLL22-S6_paired_R2.fastq.gz -S H460-FLLL22-S6.sam 2>H460-FLLL22-S6_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-FLLL22-S7_paired_R1.fastq.gz -2  H460-FLLL22-S7_paired_R2.fastq.gz -S H460-FLLL22-S7.sam 2>H460-FLLL22-S7_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-FLLL22-S8_paired_R1.fastq.gz -2  H460-FLLL22-S8_paired_R2.fastq.gz -S H460-FLLL22-S8.sam 2>H460-FLLL22-S8_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-FLLL22-S9_paired_R1.fastq.gz -2  H460-FLLL22-S9_paired_R2.fastq.gz -S H460-FLLL22-S9.sam 2>H460-FLLL22-S9_align.log 

hisat2 -p 14 -x Homo_sapiens.GRCh38 -1 H460-FLLL22-S10_paired_R1.fastq.gz -2  H460-FLLL22-S10_paired_R2.fastq.gz -S H460-FLLL22-S10.sam 2>H460-FLLL22-S10_align.log 

