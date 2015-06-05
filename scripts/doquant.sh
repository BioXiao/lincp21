#!/bin/bash
#
################
# Creates .cxb file from individual bam + ref_gtf
################
#
# Usage
# doquant.sh samplename bam_file.bam

#Setup
QUEUE=general
#serial_requeue #unrestricted #or general OR serial_requeue
NUM_THREADS=8
MAX_MEM=8000
RUN_TIME=1000

PROJECT_ROOT="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21"

ALIGN_ROOT=$PROJECT_ROOT/bam
QUANT_ROOT=$PROJECT_ROOT/quants
BOWTIE_INDEX="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/indexes/mm10/mm10_brainmap"
REF_GTF="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf"

#ARGUMENTS
SAMPLE_NAME=$1
BAMFILE=$2

#Main
OUTDIR=$QUANT_ROOT/$SAMPLE_NAME
mkdir -p $OUTDIR

echo "$SAMPLE_NAME"
sbatch -J ${SAMPLE_NAME}_quant -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffquant -p $NUM_THREADS --no-update-check -o $OUTDIR $REF_GTF $BAMFILE"
