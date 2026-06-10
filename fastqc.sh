#! /usr/bin/env bash
  
RUN_PATH=/Users/swarnakanchan/Documents/New_RNAseq/Demuxed
cd $RUN_PATH
for file in $(ls $RUN_PATH)
do
    SAMPLE=`basename $file`
    fastqc -t 16 ${SAMPLE} -o /Users/swarnakanchan/Documents/New_RNAseq/Demuxed/fastqc_raw
done
~    
