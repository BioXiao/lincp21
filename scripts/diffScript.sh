#DIANA wt v ko lincp21 leg 
#WTS:
# JR878, JR880, JR881
#KOs:
# JR879, JR882, JR883
###./cuffdiff_strain.sh Trp53cor1 E14.5_Leg_WTvKO \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR879/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb

####RIB####
#WT: 915,923,931
#KO: 916,924,932
#./cuffdiff_strain.sh Trp53cor1 E14.5_RIB \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR915/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR923/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR931/abundances.cxb \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR916/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR924/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR932/abundances.cxb

####LIVER####
#WT: 917,933,925 
#KO: 918,926,934
#./cuffdiff_strain.sh Trp53cor1 E14.5_LIVER \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR918/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb

## Liver without KO_0
#./cuffdiff_strain.sh Trp53cor1 E14.5_LIVER_noKO0 \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb

####HEART####
#WT: 919,927,935
#KO: 920,928,936
#./cuffdiff_strain.sh Trp53cor1 E14.5_HEART \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR935/abundances.cxb \
#/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR928/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR936/abundances.cxb
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROJECT_ROOT=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21
DIFF_ROOT=$PROJECT_ROOT/diff
REF_GTF="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf"
#Slurm
QUEUE=general #unrestricted #or general OR serial_requeue
NUM_THREADS=40
MAX_MEM=40000
RUN_TIME=1200
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
############WTs -- Tissue Differences
#SAMPLE_NAME="WT_TISSUES"
#AGE="ALL"
#leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
#rib="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR915/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR923/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR931/abundances.cxb"
#liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb"
#heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR935/abundances.cxb"
#Output director
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
# Submit cuffdiff
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffdiff -p $NUM_THREADS -L wt_leg,wt_rib,wt_liver,wt_heart -o $OUTDIR $REF_GTF $leg $rib $liver $heart"


###############ALL
SAMPLE_NAME="All_Conditions"
AGE="ALL"
wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
wt_rib="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR915/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR923/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR931/abundances.cxb"
wt_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb"
wt_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR935/abundances.cxb"
ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR879/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb"
ko_rib="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR916/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR924/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR932/abundances.cxb"
ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR918/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb"
ko_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR928/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR936/abundances.cxb"
#Output directory
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
# Submit cuffdiff
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffdiff -p $NUM_THREADS -L wt_leg,wt_rib,wt_liver,wt_heart,ko_leg,ko_rib,ko_liver,ko_heart -o $OUTDIR $REF_GTF $wt_leg $wt_rib $wt_liver $wt_heart $ko_leg $ko_rib $ko_liver $ko_heart"

###############ALL including JACKS
#SAMPLE_NAME="All_conditions_Jacks"
#AGE="ALL_JACKS"
#MAX_MEM=180000
#NUM_THREADS=70
#wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
#wt_rib="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR915/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR923/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR931/abundances.cxb"
#wt_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb"
#wt_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR935/abundances.cxb"
#ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR879/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb"
#ko_rib="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR916/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR924/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR932/abundances.cxb"
#ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR918/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb"
#ko_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR928/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR936/abundances.cxb"
#JACKS_wt_nodox="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/WT_nodox_1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/WT_nodox_2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/WT_nodox_3/abundances.cxb"
#JACKS_ko_nodox="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/KO_nodox_1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/KO_nodox_2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/quants/KO_nodox_3/abundances.cxb"
#Output director
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
# Submit cuffdiff
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffdiff -p $NUM_THREADS -L wt_leg,wt_rib,wt_liver,wt_heart,JACKS_mef_wt_nodox,ko_leg,ko_rib,ko_liver,ko_heart,JACKS_mef_ko_nodox -o $OUTDIR $REF_GTF $wt_leg $wt_rib $wt_liver $wt_heart $JACKS_wt_nodox $ko_leg $ko_rib $ko_liver $ko_heart $JACKS_ko_nodox"


#ALL_JACKS_norib_noliverko0
#SAMPLE_NAME="All_conditions_Jacks_norib_noliverko0"
#AGE="ALL_JACKS_norib_noliverko0"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
#ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb"
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem-per-cpu=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL --wrap="cuffdiff -p $NUM_THREADS -L wt_leg,wt_liver,wt_heart,JACKS_mef_wt_nodox,ko_leg,ko_liver,ko_heart,JACKS_mef_ko_nodox -o $OUTDIR $REF_GTF $wt_leg $wt_liver $wt_heart $JACKS_wt_nodox $ko_leg $ko_liver $ko_heart $JACKS_ko_nodox"

### ALL_J_nobad_andBrain
#SAMPLE_NAME="All_no_bad"
#AGE="everything"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
#wt_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR729/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR728/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR796/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR797/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR740/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR800/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR827/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR778/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR734/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR802/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR803/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR735/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR785/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR781/abundances.cxb"
#ko_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR743/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR786/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR805/abundances.cxb"
#wt_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR753/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR750/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR771/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR755/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR811/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR768/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR761/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR815/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR789/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR748/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR716/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR717/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR719/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR756/abundances.cxb "
#ko_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb"
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L wt_leg,wt_liver,wt_heart,JACKS_mef_wt_nodox,wt_brain_adult,wt_brain_embryo,\
#ko_leg,ko_liver,ko_heart,JACKS_mef_ko_nodox,ko_brain_adult,ko_brain_embryo \
#-o $OUTDIR $REF_GTF $wt_leg $wt_liver $wt_heart $JACKS_wt_nodox $wt_brain_adult $wt_brain_embryo \
#$ko_leg $ko_liver $ko_heart $JACKS_ko_nodox $ko_brain_adult $ko_brain_embryo"

############# 3-29-15 Adding BROAD seq ####

##### E14.5 Kidney 
ko_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO2/abundances.cxb"
wt_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT3/abundances.cxb"
#./cuffdiff_strain.sh Trp53cor1 E14.5_Kidney_b0329 $wt_kidney $ko_kidney 

####  E14.5 Leg 
##Orig leg bams
#wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_WT4/abundances.cxb"
#ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR879/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO4/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO5/abundances.cxb"

#take out WT4 and KO5 (both from the broad round of sequencing) b/c noise and JR879 in order to sex balance 
wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO4/abundances.cxb"
#./cuffdiff_strain.sh Trp53cor1 E14.5_Leg_b0329 $wt_leg $ko_leg
#./cuffdiff_strain.sh Trp53cor1 E14.5_Leg_b0331 $wt_leg $ko_leg

wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO4/abundances.cxb"
./cuffdiff_strain.sh Trp53cor1 E14.5_Leg_male $wt_leg $ko_leg


#### E14.5 Liver 
wt_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_WT2/abundances.cxb"
ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO2/abundances.cxb"
#./cuffdiff_strain.sh Trp53cor1 E14.5_Liver_b0329 $wt_liver $ko_liver 

#### E14.5 Lung 
ko_lung="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO3/abundances.cxb"
wt_lung="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT3/abundances.cxb"
#./cuffdiff_strain.sh Trp53cor1 E14.5_Lung_b0329 $wt_lung $ko_lung

#### mike MEFs
ko_mikeMEFs="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO3/abundances.cxb"
wt_mikeMEFs="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT3/abundances.cxb"
#./cuffdiff_strain.sh Trp53cor1 mike_MEFs_b0329 $wt_mikeMEFs $ko_mikeMEFs 
