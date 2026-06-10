#!/bin/bash

samtools view -bS -o H460-Control-S1.bam H460-Control-S1.sam 

samtools view -bS -o H460-Control-S2.bam H460-Control-S2.sam 

samtools view -bS -o H460-Control-S3.bam H460-Control-S3.sam 

samtools view -@ 4 -bS -o H460-Control-S4.bam H460-Control-S4.sam 

samtools view -@ 4 -bS -o H460-Control-S5.bam H460-Control-S5.sam 

samtools view -@ 4 -bS -o H460-FLLL22-S6.bam H460-FLLL22-S6.sam 

samtools view -@ 4 -bS -o H460-FLLL22-S7.bam H460-FLLL22-S7.sam 

samtools view -@ 4 -bS -o H460-FLLL22-S8.bam H460-FLLL22-S8.sam 

samtools view -@ 4 -bS -o H460-FLLL22-S9.bam H460-FLLL22-S9.sam 

samtools view -@ 4 -bS -o H460-FLLL22-S10.bam H460-FLLL22-S10.sam 

