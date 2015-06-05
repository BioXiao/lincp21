#/bin/bash
###############
# Master control script for full cuffdiff analysis of BrainMap
###############

#Setup
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21
PROJECT_ROOT=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21
DIFF_ROOT=$PROJECT_ROOT/diff
REF_GTF="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf"

#Slurm
QUEUE=general #unrestricted #or general OR serial_requeue
NUM_THREADS=10
MAX_MEM=8000
RUN_TIME=1200

###########
#Main
###########
SAMPLE_NAME=$1
AGE=$2
KO_CXB=$4
WT_CXB=$3
#Output director
OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}
mkdir -p $OUTDIR

# Submit cuffdiff
sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffdiff -p $NUM_THREADS -L WT,$SAMPLE_NAME -o $OUTDIR $REF_GTF $WT_CXB $KO_CXB"
