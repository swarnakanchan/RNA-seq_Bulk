# Set working directory directory setwd("/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted")

library(Rsamtools)
library(GenomicFeatures)
library(GenomicAlignments)
library(BiocParallel)
library(DESeq2)
library(pheatmap)
library(RColorBrewer)
library(AnnotationDbi)
library(readr)
library(dplyr)
library ("txdbmaker")

bam_files <- c("/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-Control-S1.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-Control-S2.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-Control-S3.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-Control-S4.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-Control-S5.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-FLLL22-S6.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-FLLL22-S7.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-FLLL22-S8.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-FLLL22-S9.CPsorted.bam", "/Users/swarnakanchan/Documents/New_RNAseq/trimmed/paired/H460/CP_sorted/H460-FLLL22-S10.CPsorted.bam")


bamfiles <- BamFileList(bam_files)

seqinfo(bamfiles[1])


dir <- "/Users/swarnakanchan/Documents/RNAseq/genome"

gtffile <- file.path(dir,"Homo_sapiens.GRCh38.108.gtf")

txdb <- makeTxDbFromGFF(gtffile, format="gtf", circ_seqs=character(0))

exonsByGene <- exonsBy(txdb, by="gene")

# Use multiple cores


num_cores <- 10
param <- MulticoreParam(workers = num_cores)
register(param)

se <- summarizeOverlaps(features=exonsByGene, reads=bamfiles, mode="IntersectionStrict", singleEnd=F, ignore.strand=T, fragments=F)


counts_all <- assays(se)$counts
counts_df <- as.data.frame(counts_all)
write.csv(counts_df, file = "counts_H460_all.csv", row.names = TRUE)


> sessionInfo()


