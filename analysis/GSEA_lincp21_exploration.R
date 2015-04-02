#lincp21 GSEA 

#setup 
#cummerbund, directory, cuff, genesets, gsea packages

library(cummeRbund)
library(GSA)
library(limma)

library(gplots)
library(marray)
library(ggplot2)
library(gtable)
library(gridExtra)
library(RColorBrewer)
library(RMySQL)

#heart
dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_HEART"
cuff<-readCufflinks(dir=dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome="mm10")

#leg
dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1"
cuff<-readCufflinks(dir=dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome="mm10")


population<-genes(cuff)
population.diff<-diffData(population)
annotation<-annotation(genes(cuff))
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

df.pop<-data.frame("short_name"=toupper(gene_names$gene_short_name),"test_stat"=gene_names$test_stat, "sig"=gene_names$significant)
df.pop.unique<-unique(df.pop)
rownames(df.pop.unique)<-NULL
df.pop.unique.ordered<-df.pop.unique[order(df.pop.unique$test_stat),]
Input.df<-df.pop.unique.ordered
Input.df$short_name<-as.character(Input.df$short_name)


reactome_gs <- GSA.read.gmt("/n/rinn_data1/users/agroff/GSEA/c2.cp.reactome.v4.0.symbols.gmt")
peril_gs<- GSA.read.gmt("/n/rinn_data1/users/agroff/seq/PERIL/analysis/GBA/perilsignature.gmt")
kegg_gs<-GSA.read.gmt("/n/rinn_data1/annotations/gsea/msigdb_v4.0_files_to_download_locally/msigdb_v4.0_GMTs/c2.cp.kegg.v4.0.symbols.gmt")

reactome_pvl_mat <- get_gene_set_p_vals(Input.df, reactome_gs,alternative="either")
reactome_pvl_corrected <- get_gene_set_q_vals(reactome_pvl_mat)
reactome_pvl_corrected<-rbind(reactome_pvl_corrected,reactome_pvl_corrected)

reactome_zscores<-get_gene_set_ztest(Input.df,reactome_gs)
reactome_zscores<-cbind(reactome_zscores,reactome_zscores)


kegg_pvl_mat <- get_gene_set_p_vals(Input.df, kegg_gs, alternative="either")
kegg_pvl_corrected <- get_gene_set_q_vals(kegg_pvl_mat)
kegg_pvl_corrected<-rbind(kegg_pvl_corrected,kegg_pvl_corrected)
kegg_zscores<-get_gene_set_ztest(Input.df,kegg_gs)
kegg_zscores<-cbind(kegg_zscores,kegg_zscores)



k <- 100
myColors<-maPalette(low="blue",mid="white",high="red",k=k)
#myBreaks<-seq(-max(abs(x)),max(abs(x)),k+1)
myBreaks<-seq(-2,2,length.out=(k+1))
enrichmentBreaks<-seq(0,6,length.out=(k+1))
InputCols<-maPalette(low="white",high="red",k=100)

x<-(-log10(t(reactome_pvl_corrected[,which(colMins(reactome_pvl_corrected) < 0.001)])))
x_ordered<-x[order(x[,1], decreasing=TRUE),]
if(length(x_ordered)>50){x_ordered<-x_ordered[1:50,]}
noinfinities_x<-x_ordered[which(x_ordered !="Inf")]
x_max<-max(noinfinities_x)+100
x_ordered[x_ordered=="Inf"]<-x_max

if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=InputCols,breaks=enrichmentBreaks, margins=c(1,20),dendrogram="both",labCol=c(""),cexRow =1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}
rm(x)
rm(x_ordered)

x<-reactome_zscores[which(colMins(reactome_pvl_corrected) < 0.001),]
x_ordered<-x[order(x[,1], decreasing=TRUE),]
if(length(x_ordered)>50){x_ordered<-x_ordered[1:50,]}
x_ordered<-as.matrix(x_ordered)
if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=myColors,breaks=myBreaks,margins=c(1,20),dendrogram="both",labCol=c(""),cexRow = 1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}
rm(x)
reactome_lists<-unlist(row.names(x_ordered))
############reactome ordered_x###


#############KEGG################

InputCols<-maPalette(low="white",high="red",k=100)

x<-(-log10(t(kegg_pvl_corrected[,which(colMins(kegg_pvl_corrected) < 0.001)])))
x_ordered<-x[order(x[,1], decreasing=TRUE),]
if(length(x_ordered)>50){x_ordered<-x_ordered[1:50,]}
noinfinities_x<-x_ordered[which(x_ordered !="Inf")]
x_max<-max(noinfinities_x)+100
x_ordered[x_ordered=="Inf"]<-x_max

if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=InputCols,breaks=enrichmentBreaks, margins=c(1,20),dendrogram="both",labCol=c(""),cexRow =1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}
rm(x)
rm(x_ordered)

x<-kegg_zscores[which(colMins(kegg_pvl_corrected) < 0.001),]

x_ordered<-x[order(x[,1], decreasing=TRUE),]

if(length(x_ordered)>50){x_ordered<-x_ordered[1:50,]}
x_ordered<-as.matrix(x_ordered)

if(dim(x_ordered)[1]>1){
  heatmap.2(x_ordered, trace="none",col=myColors,breaks=myBreaks,margins=c(1,20),dendrogram="both",labCol=c(""),cexRow = 1, offsetRow=0)
}else{print("Not enough significant categories to print a heatmap!")}


kegg_lists<-unlist(row.names(x_ordered))



#Collect genesets of interest from geneset list ##USE PVL_MAT
mapply(grep,"_Notch",reactome_gs,ignore.case=TRUE,value=TRUE)
mapply(grep,"_Notch",reactome_gs[2],ignore.case=TRUE,value=TRUE)
notchlists<-as.vector(mapply(grep,"_Notch",reactome_gs[2],ignore.case=TRUE))
reactome_gs[[1]][[notchlists]]

listsOfInterest<-row.names(x_ordered)
#lists<-as.vector(mapply(grep,listsOfInterest,reactome_gs[2],ignore.case=TRUE))
lists<-as.vector(mapply(grep,listsOfInterest,kegg_gs[2],ignore.case=TRUE))

listsOfInterest<-unlist(lists)

##which genes in my data are causing signal? 
#see which are most skewed?

#MyGenesets<-reactome_gs$genesets[listsOfInterest]
##MyGenesets<-reactome_gs$genesets[lists]
#MyGenesetNames<-reactome_gs$geneset.names[listsOfInterest]

KEGG_lists<-as.vector(mapply(grep,kegg_lists,kegg_gs[2],ignore.case=TRUE))
REACTOME_lists<-as.vector(mapply(grep,reactome_lists,reactome_gs[2],ignore.case=TRUE))

kegg<-unlist(KEGG_lists)
reactome<-unlist(REACTOME_lists)

#MyGenesets<-kegg_gs$genesets[kegg]
#MyGenesetNames<-kegg_gs$geneset.names[kegg]

MyGenesets<-reactome_gs$genesets[reactome]
MyGenesetNames<-reactome_gs$geneset.names[reactome]

gene_set_index <- function(genelist, short_names){
  which(short_names %in% genelist)   
}

my_gene_set_indices <- lapply(MyGenesets, function(genelist){
  gene_set_index(genelist,Input.df$short_name)
})

#visualize and label! 
#list of DFs -- geneset name, index, gene short name, test_stat, rownumber/total

#dat<-diffTable(genes(cuff))
#sigDat<-getSigTable(cuff)
dfs<-lapply(MyGenesets,function(genelist){
  indicies<-gene_set_index(genelist,Input.df$short_name)
  shortnames<-Input.df$short_name[indicies]
  test_stat<-Input.df$test_stat[indicies]
  sig<-as.character(Input.df$sig[indicies])
  CumulativeDensity<-indicies/length(Input.df$short_name)
  df<-data.frame(cbind(indicies,shortnames,test_stat,CumulativeDensity,sig))
  df$test_stat<-as.numeric(as.character(df$test_stat))
  df$indicies<-as.numeric(as.character(df$indicies))
  df
})
names(dfs)<-MyGenesetNames
example<-dfs[[35]]
name<-names(dfs[35])
library(ggplot2)


pdf("Heart_reactome_striated_musclecontraction_GSEA.pdf")
ggplot(example, aes(indicies,test_stat,label=shortnames,color=sig))+geom_point()+geom_text()+theme_bw()+ggtitle(name)
dev.off()
