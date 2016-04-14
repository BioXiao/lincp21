PROJECT_ROOT=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21
DIFF_ROOT=$PROJECT_ROOT/diff
REF_GTF="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf"
QUEUE=general #unrestricted #or general OR serial_requeue
NUM_THREADS=40
MAX_MEM=80000
RUN_TIME=1200

ko_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO2/abundances.cxb"
wt_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT3/abundances.cxb"

#original leg 
#wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_WT4/abundances.cxb"
#ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR879/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO4/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO5/abundances.cxb"

#updated leg -- removed wt4 and ko5 (noisy broad samples) and JR879 in order to sexmatch 
wt_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR881/abundances.cxb"
ko_leg="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Leg_KO4/abundances.cxb"

wt_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_WT2/abundances.cxb"
ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO2/abundances.cxb"

ko_lung="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO3/abundances.cxb"
wt_lung="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_WT3/abundances.cxb"

ko_mikeMEFs="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_KO3/abundances.cxb"
wt_mikeMEFs="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_mikeMEFs_WT3/abundances.cxb"

### Broad_all_1
# heart, all current tissues, brain, no JACKs 
#SAMPLE_NAME="BROAD_ALL_1"
#AGE="ALL_TISSUES"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
wt_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR729/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR728/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR796/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR797/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR740/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR800/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR827/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR778/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR734/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR802/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR803/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR735/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR785/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR781/abundances.cxb"
ko_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR743/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR786/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR805/abundances.cxb"
wt_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR753/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR750/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR771/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR755/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR811/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR768/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR761/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR815/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR789/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR748/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR716/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR717/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR719/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR756/abundances.cxb"
ko_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb"
wt_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR935/abundances.cxb"
ko_heart="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR928/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR936/abundances.cxb"

#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L \
#wt_leg,wt_liver,wt_heart,wt_brain_adult,wt_brain_embryo,wt_kidney,wt_lung,wt_MEFs,\
#ko_leg,ko_liver,ko_heart,ko_brain_adult,ko_brain_embryo,ko_kidney,ko_lung,ko_MEFs \
#-o $OUTDIR $REF_GTF \
#$wt_leg $wt_liver $wt_heart $wt_brain_adult $wt_brain_embryo $wt_kidney $wt_lung $wt_mikeMEFs \
#$ko_leg $ko_liver $ko_heart $ko_brain_adult $ko_brain_embryo $ko_kidney $ko_lung $ko_mikeMEFs"



### Broad_all_2
# heart, all current tissues, brain, no JACKs
# removed noisy broad leg libraries 

#SAMPLE_NAME="BROAD_ALL_2"
#AGE="ALL_TISSUES"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR

#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L \
#wt_leg,wt_liver,wt_heart,wt_brain_adult,wt_brain_embryo,wt_kidney,wt_lung,wt_MEFs,\
#ko_leg,ko_liver,ko_heart,ko_brain_adult,ko_brain_embryo,ko_kidney,ko_lung,ko_MEFs \
#-o $OUTDIR $REF_GTF \
#$wt_leg $wt_liver $wt_heart $wt_brain_adult $wt_brain_embryo $wt_kidney $wt_lung $wt_mikeMEFs \
#$ko_leg $ko_liver $ko_heart $ko_brain_adult $ko_brain_embryo $ko_kidney $ko_lung $ko_mikeMEFs"


# BROAD_all_wtvko
#SAMPLE_NAME="BROAD_ALL_WTvKO"
#AGE="ALL_TISSUES_WTvKO"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
#all_wt=$wt_leg,$wt_liver,$wt_heart,$wt_brain_adult,$wt_brain_embryo,$wt_kidney,$wt_lung,$wt_mikeMEFs
#all_ko=$ko_leg,$ko_liver,$ko_heart,$ko_brain_adult,$ko_brain_embryo,$ko_kidney,$ko_lung,$ko_mikeMEFs
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L wt,ko -o $OUTDIR $REF_GTF $all_wt $all_ko"


#ko_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO2/abundances.cxb"
#wt_kidney="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_WT2/abundances.cxb"
#wt_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR925/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_WT1/abundances.cxb"
#ko_liver="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Liver_KO2/abundances.cxb"
#wt_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR729/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR728/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR803/abundances.cxb"
#ko_brain_adult="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR743/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR786/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR805/abundances.cxb"
#wt_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR753/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR750/abundances.cxb"
#ko_brain_embryo="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb"



# BROAD_all_wtvko
#SAMPLE_NAME="BROAD_ALL_WTvKO"
#AGE="ALL_Tissues_Balanced"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR

#all_wt=$wt_leg,$wt_liver,$wt_heart,$wt_brain_adult,$wt_brain_embryo,$wt_kidney,$wt_lung,$wt_mikeMEFs
#all_ko=$ko_leg,$ko_liver,$ko_heart,$ko_brain_adult,$ko_brain_embryo,$ko_kidney,$ko_lung,$ko_mikeMEFs
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L wt,ko -o $OUTDIR $REF_GTF $all_wt $all_ko"



######## SEX DIFFS ###### 
# BROAD_all_wtvko
#SAMPLE_NAME="BROAD_KOsexdiffs"
#AGE="KO_sexDiffs"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR
#ko_females="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR934/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR936/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO3/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR786/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb"
#ko_males="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Kidney_KO1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/lincp21_Lung_KO1/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR743/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb"
#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L female,male -o $OUTDIR $REF_GTF $ko_females $ko_males"

#####################################################################################################################################


### Broad_all_3
# heart, all current tissues, brain, no JACKs
# removed noisy broad leg libraries 
# removed Kidney (1/2 KOs actually a het, and cant work with just 1 KO), also removed MEFs (they'll be used on their own but not with tissues)


#SAMPLE_NAME="BROAD_ALL_3"
#AGE="ALL_TISSUES"
#OUTDIR=$DIFF_ROOT/${SAMPLE_NAME}_${AGE}
#mkdir -p $OUTDIR

#sbatch -J "${SAMPLE_NAME}" -t $RUN_TIME --mem=$MAX_MEM -N 1 -n $NUM_THREADS -p $QUEUE --mail-type=FAIL \
#--wrap="cuffdiff -p $NUM_THREADS -L \
#wt_leg,wt_liver,wt_heart,wt_brain_adult,wt_brain_embryo,wt_lung,\
#ko_leg,ko_liver,ko_heart,ko_brain_adult,ko_brain_embryo,ko_lung \
#-o $OUTDIR $REF_GTF \
#$wt_leg $wt_liver $wt_heart $wt_brain_adult $wt_brain_embryo $wt_lung \
#$ko_leg $ko_liver $ko_heart $ko_brain_adult $ko_brain_embryo $ko_lung"
