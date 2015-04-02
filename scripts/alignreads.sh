#!/bin/bash
#
################
#Master Alignment script for fastq files specifically from BrainMap project
################
#

#Usage
# alignreads.sh samplename read1.fq.gz[,read1_rep2.fq.gz] read2.fq.gz[,read2_rep2.fq.gz]

#Setup
QUEUE=general #unrestricted #or general OR serial_requeue
NUM_THREADS=8
MAX_MEM=10000
RUN_TIME=1600
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21
PROJECT_ROOT="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21"

ALIGN_ROOT=$PROJECT_ROOT/bam

BOWTIE_INDEX="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/indexes/mm10/mm10_brainmap"

REF_GTF="-G /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf"

#ARGUMENTS
SAMPLE_NAME=$1
READ1=$2
READ2=$3

#Main
OUTDIR=$ALIGN_ROOT/$SAMPLE_NAME
mkdir -p $OUTDIR

echo "$SAMPLE_NAME"
sbatch -J $SAMPLE_NAME -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -N 1 -p $QUEUE --mail-type=FAIL --wrap="tophat --no-coverage-search $REF_GTF --max-multihits 10 -p $NUM_THREADS -o $OUTDIR $BOWTIE_INDEX $READ1 $READ2"
