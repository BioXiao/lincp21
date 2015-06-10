#Compare summary, aggregate from individual analysis, and summary using contrats

# 311 unique DE agross aggregates
#tons from sumary
#305 from summary with contratss

library(cummeRbund)
library(ggplot2)
library(reshape2)
alpha<-0.05 
genome<-"mm10"

#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_3_ALL_TISSUES/"
all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_4_contrasts_ALL_TISSUES" #always use contrasts from now on! 
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

sig_contrasts<-getSig(cuff)
contrast_genes<-getGenes(cuff,sig_contrasts)
contrastAnnot<-annotation(contrast_genes)

DE<-read.table("DE_genes_aggregated_annotation.tab",header=TRUE)

a<-unique(DE$gene_id)
b<-contrastAnnot$gene_id

inters<-intersect(a,b) #193 0.O
diff<-setdiff(a,b) #118 

