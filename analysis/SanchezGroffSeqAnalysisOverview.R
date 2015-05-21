# Final Full Paper Analysis Overview
# Lincp21 Paper Seq Analysis

library(cummeRbund)
alpha<-0.05 
genome<-"mm10"

# Get universe of DE genes
  # all together analysis
all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_3_ALL_TISSUES/"
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

getRelevantSigTable<-function(cuff,alpha){
  m<-getSigTable(cuff,alpha)
  comparisons<-c("wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo","wt_heartvsko_heart","wt_legvsko_leg","wt_livervsko_liver","wt_lungvsko_lung")
  m<-m[,comparisons]
  m<-as.data.frame(m)
  m$sum<-rowSums(m,na.rm=TRUE)
  m
}
m<-getRelevantSigTable(cuff,alpha)
DEuniverse<-m[which(m$sum>0),]
deGenes<-rownames(DEuniverse)

  # from individuals: 
brain_dir_adult<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Adult"
brain_dir_embryo<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Embryonic/"
heart_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/oldDiffs/Trp53cor1_E14.5_HEART/"
leg_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_Leg_b0331/"
liver_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_Liver_b0329/"
lung_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_Lung_b0329/"

brain_embryo<-readCufflinks(dir=brain_dir_embryo,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
brain_adult<-readCufflinks(dir=brain_dir_adult,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
heart<-readCufflinks(dir=heart_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
leg<-readCufflinks(dir=leg_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
liver<-readCufflinks(dir=liver_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
lung<-readCufflinks(dir=lung_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

BE_sig<-getSig(brain_embryo,alpha)
BA_sig<-getSig(brain_adult,alpha)
heartsig<-getSig(heart,alpha)
legsig<-getSig(leg,alpha)
liverSig<-getSig(liver,alpha)
lungSig<-getSig(lung,alpha)

allSigGenes<-c(BA_sig,BE_sig,heartsig,legsig,liverSig,lungSig)
uniqueSig<-unique(allSigGenes)
uniqueSigGenes<-getGenes(leg,uniqueSig)
uniqueSigAnnot<-annotation(uniqueSigGenes)
chr17<-uniqueSigAnnot[grep("chr17",uniqueSigAnnot$locus),]
#write.table(uniqueSig,file="ensembleIDS_allSigDE_fromIndividuals.tab",quote=TRUE,sep="\t",row.names=FALSE,col.names=FALSE)
#write.table(uniqueSigAnnot,file="DE_genes_aggregated_annotation.tab",quote=TRUE,sep="\t",row.names=FALSE,col.names=TRUE)
#write.table(uniqueSigAnnot$gene_short_name,file="shortNames_allSigDE_fromIndividuals.tab",quote=TRUE,sep="\t",row.names=FALSE,col.names=FALSE)


#GO DE
library(ReactomePA)
library(DOSE)
geneNames<-uniqueSigAnnot$gene_short_name
library(clusterProfiler)
require(biomaRt)

ensembl <- useMart("ENSEMBL_MART_ENSEMBL","mmusculus_gene_ensembl", 
                   host="www.ensembl.org")

#Get entrezIDs
getEntrezIDs<-function (geneNames)
{
  tmp <- getBM(attributes = c("entrezgene"), filters = "mgi_symbol", values = geneNames, mart = ensembl)
  tmp
}
sigEntrez<-getEntrezIDs(geneNames)
sigEZ<-strsplit(as.character(sigEntrez), ", ")
sigEZ<-unlist(sigEZ)
require(org.Mm.eg.db) #mapping of entrez IDs to genbank
goBP<-enrichGO(gene=sigEZ, organism="mouse",ont="BP",pvalueCutoff=0.01,readable=T)
goMF<-enrichGO(gene=sigEZ, organism="mouse",ont="MF",pvalueCutoff=0.01,readable=T)
goCC<-enrichGO(gene=sigEZ, organism="mouse",ont="CC",pvalueCutoff=0.01,readable=T)
kegg<-enrichKEGG(gene=sigEZ, organism="mouse",pvalueCutoff=.01, readable=T)
pathway<-enrichPathway(gene=sigEZ,organism="mouse",pvalueCutoff=0.01, readable=T)
plot(goBP,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched BP")+theme_bw()
plot(goMF,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched MF")+theme_bw()
plot(goCC,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched CC")+theme_bw()
plot(kegg, showCategory=20) + ggtitle("Kegg Pathways")+theme_bw()
plot(pathway,showCategory=20) + ggtitle("Reactome pathway enrichment")+theme_bw()
detach("package:biomaRt")

# Get genes that are always DE 

# Get genes that are always changing in same direction

# p21-lincp21 expression and foldchange

# expression and foldchange vs lincp21 for all "always changing" genes

# Repetitive figure elements
  # for each comparison::
    # lincp21, p21, lacz
    # universe of DEgenes foldchange
    # cisplot
    # plot of always changing genes 
    # 

# Summary plot of always changing genes 


# Summary cis plot 

#### FIGURE 5 ###

#Cdkn1a Barplots from together analysis 
Cdkn1a<-getGene(cuff,"Cdkn1a")
pdf("Cdkn1a_expression.pdf")
expressionBarplot(Cdkn1a)+theme_bw()
dev.off()

Glo1<-getGene(cuff,"Glo1")
pdf("Glo1_expression.pdf")
expressionBarplot(Glo1)+theme_bw()
dev.off()