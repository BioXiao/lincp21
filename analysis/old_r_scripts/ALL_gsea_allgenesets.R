#EVERYTHING gsea
library(GSA)
library(cummeRbund)
library(limma)
library(gplots)
library(marray)
library(ggplot2)
library(gtable)
library(gridExtra)
library(RColorBrewer)
library(RMySQL)
all_gs<-GSA.read.gmt("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/p53_genesets/msigdb.v4.0.symbols.gmt")

#cuffd<-JACKS_all
cuffd<-heart


population<-genes(cuffd)
population.diff<-diffData(population)
#popforlater<-population.diff
#population.diff<-popforlater
###pd<-population.diff[which(population.diff$sample_1=="wt_nodox"&population.diff$sample_2=="wt_dox"),]
#pd<-population.diff[which(population.diff$sample_1=="ko_nodox"&population.diff$sample_2=="ko_dox"),]
#pd<-population.diff[which(population.diff$sample_1=="wt_dox"&population.diff$sample_2=="ko_dox"),]
#pd<-population.diff[which(population.diff$sample_1=="wt_nodox"&population.diff$sample_2=="ko_nodox"),]

#population.diff<-pd

annotation<-annotation(genes(cuffd))
#a<-ddply(annotation,.(gene_short_name),head,n=1)
#annotation<-a

gene_names<-merge(annotation,population.diff)

gene_set_index <- function(genelist, short_names){
  which(short_names %in% genelist)   
}

get_gene_set_p_vals <- function(input, gs, alternative){
  gene_set_indices <- lapply(gs$genesets, function(genelist){
    gene_set_index(genelist,input$short_name)
  })
  pvl<-lapply(gene_set_indices,geneSetTest,input$test_stat, alternative=alternative)
  pvl_mat<-as.data.frame(t(unlist(pvl)))
  colnames(pvl_mat) <- gs$geneset.names
  return(pvl_mat)
}

get_gene_set_q_vals <- function(pvl_mat, method="bonferroni"){
  comp_corrected <- matrix(p.adjust(pvl_mat, method=method), nrow=nrow(pvl_mat), ncol=ncol(pvl_mat))
  colnames(comp_corrected) <- colnames(pvl_mat)
  rownames(comp_corrected) <- rownames(pvl_mat)
  return(comp_corrected)
}

colMins<-function(x){
  apply(x,2,min)
}
rowMins<-function(x){
  apply(x,1,min)
}

InputCols<-maPalette(low="white",high="red",k=100)


ztest<-function(samp,pop){
  (mean(samp,na.rm=T)-mean(pop,na.rm=T))/sd(pop,na.rm=T)
}


get_gene_set_ztest <- function(scoring_df, gs){  
  gene_set_indices <- lapply(gs$genesets, function(genelist){
    gene_set_index(genelist, scoring_df$short_name)
  })
  
  #  zscores <- apply(scoring_df$,2, function(mat_col){
  #  		lapply(gene_set_indices,function(gsi){
  #					ztest(mat_col[gsi],mat_col)})
  #     })
  
  zscores <- lapply(gene_set_indices,function(gsi){
    ztest(scoring_df$test_stat[gsi],scoring_df$test_stat)
  })  
  
  zscore_mat<-do.call(rbind,lapply(zscores,unlist))
  rownames(zscore_mat) <- gs$geneset.names
  colnames(zscore_mat) <- "zscore"
  return(zscore_mat)
}


df.pop<-data.frame("short_name"=toupper(gene_names$gene_short_name),"test_stat"=gene_names$test_stat)
df.pop.unique<-unique(df.pop)
rownames(df.pop.unique)<-NULL
df.pop.unique.ordered<-df.pop.unique[order(df.pop.unique$test_stat),]
Input.df<-df.pop.unique.ordered
Input.df$short_name<-as.character(Input.df$short_name)

#p53_pval_mat<-get_gene_set_p_vals(Input.df, p53_gs,alternative="either")
#p53_pval_corrected<-get_gene_set_q_vals(p53_pval_mat)
#p53_pval_corrected<-rbind(p53_pval_corrected,p53_pval_corrected)
#p53_zscores<-get_gene_set_ztest(Input.df,p53_gs)
#p53_zscores<-cbind(p53_zscores,p53_zscores)

ALL_pval_mat<-get_gene_set_p_vals(Input.df,all_gs,alternative="either")
all_pval_corrected<-get_gene_set_q_vals(ALL_pval_mat)
all_pval_corrected<-rbind(all_pval_corrected,all_pval_corrected)

all_zscores<-get_gene_set_ztest(Input.df,all_gs)
all_zscores<-cbind(all_zscores,all_zscores)

k <- 100
myColors<-maPalette(low="blue",mid="white",high="red",k=k)
myBreaks<-seq(-2,2,length.out=(k+1))
enrichmentBreaks<-seq(0,6,length.out=(k+1))




rm(x)
rm(x_max)
rm(x_ordered)


#ALL enrichment: 

InputCols<-maPalette(low="white",high="red",k=100)

x<-(-log10(t(all_pval_corrected[,which(colMins(all_pval_corrected) < 0.0001)])))
x_ordered<-x[order(x[,1], decreasing=TRUE),]
heart_gsea<-x_ordered
if(length(x_ordered)>100){x_ordered<-x_ordered[1:100,]}
noinfinities_x<-x_ordered[which(x_ordered !="Inf")]
x_max<-max(noinfinities_x)+100
x_ordered[x_ordered=="Inf"]<-x_max



if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=InputCols,breaks=enrichmentBreaks, margins=c(1,20),dendrogram="both",labCol=c(""),cexRow =1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}

rm(x_ordered)
rm(x_max)
rm(x)


#ALL zscore: 


x<-all_zscores[which(colMins(all_pval_corrected) < 0.001),]

x_ordered<-x[order(x[,1], decreasing=TRUE),]

if(length(x_ordered)>500){x_ordered<-x_ordered[1:500,]}
x_ordered<-as.matrix(x_ordered)

if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=myColors,breaks=myBreaks,margins=c(1,20),dendrogram="both",labCol=c(""),cexRow = 1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}

rm(x_ordered)
rm(x)



cuffd<-liver
population<-genes(cuffd)
population.diff<-diffData(population)
annotation<-annotation(genes(cuffd))
gene_names<-merge(annotation,population.diff)
df.pop<-data.frame("short_name"=toupper(gene_names$gene_short_name),"test_stat"=gene_names$test_stat)
df.pop.unique<-unique(df.pop)
rownames(df.pop.unique)<-NULL
df.pop.unique.ordered<-df.pop.unique[order(df.pop.unique$test_stat),]
Input.df<-df.pop.unique.ordered
Input.df$short_name<-as.character(Input.df$short_name)
ALL_pval_mat<-get_gene_set_p_vals(Input.df,all_gs,alternative="either")
all_pval_corrected<-get_gene_set_q_vals(ALL_pval_mat)
all_pval_corrected<-rbind(all_pval_corrected,all_pval_corrected)
all_zscores<-get_gene_set_ztest(Input.df,all_gs)
all_zscores<-cbind(all_zscores,all_zscores)
InputCols<-maPalette(low="white",high="red",k=100)
x<-(-log10(t(all_pval_corrected[,which(colMins(all_pval_corrected) < 0.0001)])))
x_ordered<-x[order(x[,1], decreasing=TRUE),]
