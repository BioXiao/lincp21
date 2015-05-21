#lincp21 replicating JACKS analysis and getting genesets 
library(Hmisc)
library(cummeRbund)
untreated_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/JACKS_Mef_untreated"
alpha<-0.05 
genome<-"mm10"
untreated.cuff<-readCufflinks(dir=untreated_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
untreated.sigIDs<-getSig(untreated.cuff,alpha)
untreated.sigGenes<-getGenes(untreated.cuff,untreated.sigIDs)
untreatedDat<-diffData(untreated.sigGenes)
untreatedDat<-untreatedDat[order(untreatedDat$log2_fold_change),]
untreatedAnnot<-annotation(untreated.sigGenes)
untreatedDat<-merge(untreatedDat,untreatedAnnot,by.x="gene_id",by.y="gene_id")
untreated_AA_up<-untreatedDat[which(untreatedDat$log2_fold_change>0),] #AA=Abbie Analysis
untreated_AA_down<-untreatedDat[which(untreatedDat$log2_fold_change<0),]


treated_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/JACKS_Mef_treated"
treated.cuff<-readCufflinks(dir=treated_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
treated.sigIDs<-getSig(treated.cuff,alpha)
treated.sigGenes<-getGenes(treated.cuff,treated.sigIDs)
treatedDat<-diffData(treated.sigGenes)
treatedAnnot<-annotation(treated.sigGenes)
treatedDat<-merge(treatedDat,treatedAnnot,by.x="gene_id",by.y="gene_id")
treatedDat<-treatedDat[order(treatedDat$log2_fold_change),]
treated_AA_up<-treatedDat[which(treatedDat$log2_fold_change>0),]
treated_AA_down<-treatedDat[which(treatedDat$log2_fold_change<0),]



#From JACKS supplement
untreated_up<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_untreated_up_genelist.tab")
untreated_down<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_untreated_down_genelist.tab")
treated_up<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_treated_up_genelist.tab")
treated_down<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/jacks_treated_down_genelist.tab")

treated_sig<-c(treated_up,treated_down)
untreated_sig<-c(untreated_up,untreated_down)


makegenelist<-function(x){
  tmp<-as.character(x$V1)
  tmp<-tolower(tmp)
  tmp<-capitalize(tmp)
  tmp  
}
untreated_up<-makegenelist(untreated_up)
untreated_down<-makegenelist(untreated_down)
treated_down<-makegenelist(treated_down)
treated_up<-makegenelist(treated_up)

#overlap their genes-our genes (their data/our analysis) 
untreatedUP_genesJACKS<-getGenes(untreated.cuff,untreated_up) #(87 vs 38 from AA)
untreatedDOWN_genesJACKS<-getGenes(untreated.cuff,untreated_down)# (56 vs 39 from AA)
treatedUP_genesJACKS<-getGenes(treated.cuff,treated_up)# (254 vs 63 from AA)
treatedDOWN_genesJACKS<-getGenes(treated.cuff,treated_down)#(648 vs 206 from AA) 

untreated_up_overlap<-intersect(untreated_AA_up$gene_short_name, untreated_up) #16 overlap
untreated_down_overlap<-intersect(untreated_AA_down$gene_short_name,untreated_down) #9 
treated_up_overlap<-intersect(treated_AA_up$gene_short_name,treated_up) #34 overlap
treated_down_overlap<-intersect(treated_AA_down$gene_short_name,treated_down) #133 overlap

treated_AA<-treatedDat$gene_short_name
untreated_AA<-untreatedDat$gene_short_name

treatedoverlap<-intersect(treated_AA,treated_sig)#167 overlap out of 269 that i find 
untreatedoverlap<-intersect(untreated_AA,untreated_sig) #25 out of 77 that i find 


#make GMTs of JACKS data from their paper 
makegmtdat<-function(x,name,desc){
  x<-toupper(x)
  tmp<-c(name,desc,x)
  tmpdat<-as.data.frame(t(tmp))
  write.table(tmpdat,file=paste(name,"gmt",sep="."),quote=FALSE, sep="\t",row.names=FALSE,col.names=FALSE)
  tmpdat
}
 
untreated_up_gmt<-makegmtdat(untreated_up,"Jacks_Untreated_MEFs_up","from their supplement")
untreated_down_gmt<-makegmtdat(untreated_down,"Jacks_Untreated_MEFs_down","from their supplement")
treated_up_gmt<-makegmtdat(treated_up,"Jacks_Treated_MEFs_up","from their supplement")
treated_down_gmt<-makegmtdat(treated_down,"Jacks_Treated_MEFs_down","from their supplement")