#commonGenes
#allnobaddir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_conditions_Jacks_norib_noliverko0_ALL_JACKS_norib_noliverko0"
#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_no_bad_everything"
all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_1_ALL_TISSUES"
alpha<-0.05 
genome<-"mm10"

library(cummeRbund)

cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

sig<-getSig(cuff)
sM<-getSigTable(cuff)
sM<-as.data.frame(sM)
#comparisons<-c("wt_livervsko_liver","wt_legvsko_leg","wt_heartvsko_heart","wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo")
comparisons<-c("wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo","wt_heartvsko_heart","wt_kidneyvsko_kidney","wt_legvsko_leg","wt_livervsko_liver","wt_lungvsko_lung","wt_MEFsvsko_MEFs")
sM<-sM[,comparisons]
sum<-rowSums(sM)
common<-sM[which(sum==8),]
commonIDs<-row.names(common)

commonGenes<-getGenes(cuff,commonIDs)
commonAnnot<-annotation(commonGenes)
