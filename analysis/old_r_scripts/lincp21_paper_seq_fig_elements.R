#Lincp21 paper seq overview figure elements


#alternately, anything expressed and over logfoldchange2
dat<-diffData(genes(cuff))
dat<-dat[which(abs(dat$log2_fold_change)>2),]
dat<-dat[which(dat$value_1>0.5|dat$value_2>0.5),]
sig<-dat[which(dat$significant=="yes"),]
ids<-sig$gene_id
genes<-getGenes(cuff,ids)
csFoldChangeHeatmap(genes,"WT",replicates=TRUE,replicate_num=0,cluster="both")



#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_no_bad_everything"
#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_Conditions_ALL" #all, no jacks, includes bad liver sample 
all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_1_ALL_TISSUES"

alpha<-0.05 
genome<-"mm10"
library(cummeRbund)
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

sigTable<-getSigTable(cuff,alpha)
wt<-c("wt_liver", "wt_heart","wt_leg","wt_brain")
ko<-c("ko_liver","ko_brain","ko_heart","ko_leg")
labels<-grep(paste(wt, collapse="|"),colnames(sigTable),value=TRUE)
labels<-grep(paste(ko,collapse="|"),labels,value=TRUE)
#comparisons<-c("wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo","wt_heartvsko_heart","wt_legvsko_leg","wt_livervsko_liver")
comparisons<-c("wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo","wt_heartvsko_heart","wt_kidneyvsko_kidney","wt_legvsko_leg","wt_livervsko_liver","wt_lungvsko_lung","wt_MEFsvsko_MEFs")
sigTable<-sigTable[,comparisons]
sigTable<-as.data.frame(sigTable)
sigTable$sum<-rowSums(sigTable)
sigTable<-sigTable[which(sigTable$sum>0),]
sigIDs<-row.names(sigTable)
universeIDs<-sigIDs
#load("universeOfDEgenes.rdata")
sigGenes<-getGenes(cuff,sigIDs)
dat<-diffData(sigGenes)
fpkms<-fpkmMatrix(sigGenes)

commonDEgenes<-sigTable[which(sigTable$sum==5),]
commonDEids<-row.names(commonDEgenes)
commonGenes<-getGenes(cuff,commonDEids)
commonAnnot<-annotation(commonGenes)

csDendro(sigGenes,replicates=TRUE)
csFoldChangeHeatmap(sigGenes,"wt_brain",cluster='both')
csHeatmap(sigGenes,cluster='both')
#save(sigGenes,file="universeOfDEgenes.rdata")


heart_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_HEART"
liver_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_LIVER"
rib_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_RIB"
muscle_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1"
brain_dir_adult<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Adult"
brain_dir_embryo<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Embryonic/"
alpha<-0.05 
genome<-"mm10"
heart<-readCufflinks(dir=heart_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
liver<-readCufflinks(dir=liver_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
rib<-readCufflinks(dir=rib_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
muscle<-readCufflinks(dir=muscle_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
brain_embryo<-readCufflinks(dir=brain_dir_embryo,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
brain_adult<-readCufflinks(dir=brain_dir_adult,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)






















#heart
ids<-getSig(heart,alpha)
heartSig<-getGenes(heart,ids)
#csFoldChangeHeatmap(heartSig,"WT",replicates=TRUE,replicate_num=0,cluster="row")
heartData<-diffData(heartSig)
heartData<-heartData[which(heartData$value_1>1 & heartData$value_2>1),]
heartData<-heartData[order(heartData$log2_fold_change),]
heartFPKMs<-repFpkmMatrix(heartSig)
heartFPKMs<-as.matrix(heartFPKMs)
wt_avg<-rowMeans(heartFPKMs[,4:6])
logFoldchangeTable<-log2(heartFPKMs/wt_avg)
dat.melt<-melt(logFoldchangeTable)
ggplot(dat.melt)

modifiedFoldChangeHeatmap<-function(fMat){
  f<-as.matrix(fMat)
  wt_avg<-rowMeans(fMat[,grep('wt',colnames(fMat),ignore.case=TRUE)])
  dat<-log2(fMat/wt_avg)
  dat.melt<-melt(logFoldchangeTable)
  dat.melt 
}

ids<-getSig(muscle,alpha)
legSig<-getGenes(muscle,ids)
legFPKMs<-repFpkmMatrix(legSig)
legDat<-modifiedFoldChangeHeatmap(legFPKMs)

#csFoldChangeHeatmap(heartUniverse,"WT",replicates=TRUE,replicate_num=0,cluster='row')



##JACKS COMPARISON##
#From JACKS supplement
library(Hmisc)
untreated_up<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_untreated_up_genelist.tab")
untreated_up<-as.character(untreated_up$V1)
untreated_up<-tolower(untreated_up)
untreated_up<-capitalize(untreated_up)

untreated_down<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_untreated_down_genelist.tab")
untreated_down<-as.character(untreated_down$V1)
untreated_down<-tolower(untreated_down)
untreated_down<-capitalize(untreated_down)

treated_up<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_treated_up_genelist.tab")
treated_up<-as.character(treated_up$V1)
treated_up<-tolower(treated_up)
treated_up<-capitalize(treated_up)

treated_down<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_treated_down_genelist.tab")
treated_down<-as.character(treated_down$V1)
treated_down<-tolower(treated_down)
treated_down<-capitalize(treated_down)

heart_treated_down<-getGenes(heart,treated_down)
heart_treated_up<-getGenes(heart,treated_up)
heart_untreated_down<-getGenes(heart,untreated_down)
heart_untreated_up<-getGenes(heart,untreated_up)
csFoldChangeHeatmap(heart_untreated_down,"WT",replicates=TRUE,replicate_num=0, cluster='both')
csFoldChangeHeatmap(heart_untreated_up,"WT",replicates=TRUE,replicate_num=0, cluster='both')

#some slight overlap but not much
#also not much overlap with my jacks analyses v their genelists... 





