# Final Full Paper Analysis Overview
# Lincp21 Paper Seq Analysis

library(cummeRbund)
alpha<-0.05 
genome<-"mm10"

# Get universe of DE genes
# all together analysis
all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_3_ALL_TISSUES/"
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

#embryonic brain in summary comparison
embryoIDs<-getSig(cuff,0.05,x="wt_brain_embryo",y="ko_brain_embryo") #0 
embroIDs2<-m[which(m$wt_brain_embryovsko_brain_embryo>0),]


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
pdf("bioproc_DEGO.pdf")
plot(goBP,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched BP")+theme_bw()
dev.off()
plot(goMF,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched MF")+theme_bw()
pdf("cellcompartment_DEGO.pdf")
plot(goCC,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched CC")+theme_bw()
dev.off()
pdf("UniverseDEGOKEGG.pdf")
plot(kegg, showCategory=20) + ggtitle("Kegg Pathways")+theme_bw()
dev.off()
pdf("universeDEGO_reactome.pdf")
plot(pathway,showCategory=20) + ggtitle("Reactome pathway enrichment")+theme_bw()
dev.off()
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

getLogFoldChangeTable<-function(cuff){
  fpkms<-fpkmMatrix(genes(cuff))
  cols<-c("leg","liver","heart","adult_brain","embryo_brain","lung")
  foldchangeTable<-log2(fpkms[,7:12]/fpkms[,1:6]) #log2foldchange KO/WT
  colnames(foldchangeTable)<-cols
  # negative = down in KO 
  # WT leg gene = 4018; KO leg gene = 3914
  # log2(KO/WT)=-0.0377378549
  c<-foldchangeTable
  c<-do.call(data.frame,lapply(c,function(x) replace(x,x=="-Inf",min(is.finite(x))))) #replace -Inf w NA; replace NA w column mins
  c<-do.call(data.frame,lapply(c,function(x) replace(x,x=="Inf",max(is.finite(x))))) #replace Inf w NA; replace NA with column max 
  row.names(c)<-row.names(foldchangeTable)
  c
}
c<-getLogFoldChangeTable(cuff)
m<-c


#which genes always change in the same direction (not sig) ? 
up<-c
up[up>0]<-1
up[up<0]<-NA
sum<-rowSums(up)
up<-up[which(sum==6),]

down<-c
down[down<0]<-(-1)
down[down>0]<-NA
sum<-rowSums(down)
down<-down[which(sum==-6),]


downgenes<-getGenes(cuff,row.names(down))
upgenes<-getGenes(cuff,row.names(up))
upAnnot<-annotation(upgenes) 
downAnnot<-annotation(downgenes)
allAnnot<-rbind(upAnnot,downAnnot)
chr17<-allAnnot[grep('chr17',allAnnot$locus),]
consistantGenes<-c(row.names(down),row.names(up))


library(seqbias)
library(stringr)
library(plyr)

getTable<-function(ids){
  genes<-getGenes(cuff,ids)
  fullTable<-annotation(genes)
  write("First Split",stderr())
  firstSplit<-str_split_fixed(fullTable$locus,":",2)
  write("Second Split",stderr())
  secondSplit<-str_split_fixed(firstSplit[,2],"-",2)
  fullTable$chromosome<-firstSplit[,1]
  fullTable$start<-as.numeric(secondSplit[,1])
  fullTable$end<-as.numeric(secondSplit[,2])
  fullTable<-fullTable[grep("chr17",fullTable$chromosome),]
  #  fullTable$chromosome<-factor(fullTable$chromosome, levels=names(seqlengths(mm10.granges)))
  fullTable
}

dat<-getTable(consistantGenes)

#annotate which were sig in aggregate list 
DE<-read.table("DE_genes_aggregated_annotation.tab",header=TRUE)
DE$sig<-"yes"
data<-merge(DE,dat,by.x="gene_id",by.y="gene_id",all.y=TRUE)
data$sig[which(is.na(data$sig))]<-"NO"
dat<-data
rm(data)
m$gene_id<-row.names(m)
fullTable<-merge(dat,m,by.x="gene_id",by.y="gene_id")
fullTable$length<-NULL
fullTable$coverage<-NULL
fullTable$nearest_ref_id<-NULL
fullTable$class_code<-NULL
keep<-c("gene_id","sig","gene_short_name.y","chromosome","start","end","leg","liver","heart","adult_brain","embryo_brain","lung")
fullTable<-fullTable[,keep]



# melt only the logfoldchange values 
# cast molten datafram, aggregate
variables<-c("gene_id","gene_short_name.y","sig","chromosome","start","end")
dat.melt<-melt(fullTable,id=variables)
chr17.dat.melt<-dat.melt[which(dat.melt$chromosome=="chr17"),]

#average
mean.cast<-dcast(chr17.dat.melt,gene_short_name.y~chromosome,fun.aggregate=mean)
colnames(mean.cast)<-c("name","mean")

#SE
se <- function(x) sqrt(var(x)/length(x))
se.cast<-dcast(chr17.dat.melt,gene_short_name.y~chromosome,fun.aggregate=se)
colnames(se.cast)<-c("name","se")


mean_se<-merge(se.cast,mean.cast,by.x="name",by.y="name")

dat<-merge(fullTable,mean_se,by.x="gene_short_name.y",by.y="name")
lincp21<-getGene(cuff,"Trp53cor1")
lincp21Annot<-annotation(lincp21)
lincp21_start<-29057473
centered_dat<-dat
centered_dat$start<-centered_dat$start-lincp21_start
limits<-aes(ymin=centered_dat$mean-centered_dat$se,ymax=centered_dat$mean+centered_dat$se)


pdf("chr17_consistently_reg_genes_summary.pdf")
ggplot(centered_dat,aes(start,mean,color=sig, label=gene_short_name.y))+theme_bw()+geom_point()+geom_errorbar(limits,width=0.2)+geom_hline(yintercept=0)+geom_vline(xintercept=0)+scale_color_manual(values=c("black", "red"))+geom_text(data=subset(centered_dat, sig=='yes'))
dev.off()

# Summary cis plot 


getLogFoldChangeTable<-function(cuff){
  fpkms<-fpkmMatrix(genes(cuff))
  cols<-c("leg","liver","heart","adult_brain","embryo_brain","lung")
  foldchangeTable<-log2(fpkms[,7:12]/fpkms[,1:6]) #log2foldchange KO/WT
  colnames(foldchangeTable)<-cols
  # negative = down in KO 
  # WT leg gene = 4018; KO leg gene = 3914
  # log2(KO/WT)=-0.0377378549
  c<-foldchangeTable
  c<-do.call(data.frame,lapply(c,function(x) replace(x,x=="-Inf",min(is.finite(x))))) #replace -Inf w NA; replace NA w column mins
  c<-do.call(data.frame,lapply(c,function(x) replace(x,x=="Inf",max(is.finite(x))))) #replace Inf w NA; replace NA with column max 
  row.names(c)<-row.names(foldchangeTable)
  c
}

library(stringr)
library(plyr)

strain_name<-"Trp53cor1"

#Constants
windowSize<-4000000

getTable<-function(object){
  fullTable<-annotation(genes(object))
  write("First Split",stderr())
  firstSplit<-str_split_fixed(fullTable$locus,":",2)
  write("Second Split",stderr())
  secondSplit<-str_split_fixed(firstSplit[,2],"-",2)
  fullTable$chromosome<-firstSplit[,1]
  fullTable$start<-as.numeric(secondSplit[,1])
  fullTable$end<-as.numeric(secondSplit[,2])
  fullTable
}

#locus annotation
fullTable<-getTable(cuff)

#summary mean/se logfoldchange...


fc<-getLogFoldChangeTable(cuff)
fc$gene_id<-row.names(fc)
fullTable<-merge(fullTable,fc,by.x="gene_id",by.y="gene_id")

#reduce table 
columnstokeep<-c("gene_id","gene_short_name","chromosome","start","end","leg","liver","heart","adult_brain","embryo_brain","lung")
fullTable<-fullTable[,columnstokeep]
fullTable<-ddply(fullTable,.(gene_id),head,n=1)

myGene<-fullTable[which(fullTable$gene_short_name==strain_name),]
chromosome<-myGene$chromosome
locuslength=abs(myGene$start-myGene$end)
start<-myGene$start-(windowSize/2-locuslength/2)
end<-myGene$end+(windowSize/2-locuslength/2)



genesInRegion<-fullTable[which(fullTable$chromosome==chromosome & fullTable$start>=start & fullTable$end<=end),]

genesInRegion$start<-myGene$start-genesInRegion$start #bc lincp21 - strand (draw it out) 

#which of these genes were EVER considered significant? # FULL ANALYSIS 
#sigTable<-getRelevantSigTable(cuff,alpha=0.05)
#sigTable<-as.data.frame(sigTable)
#sigTable$id<-row.names(sigTable)
#sigTable<-sigTable[which(sigTable$sum>0),]
#sigTable$sig<-sigTable$sum
#sigTable$sig[sigTable$sig>0]<-"yes"
#sigTable$sig[sigTable$sig==0]<-"no"
#sigTable<-sigTable[,c("id","sig")]
#sigGenesInRegion<-sigTable[which(sigTable$id %in% genesInRegion$gene_id),]
#data<-merge(sigTable,genesInRegion,by.x="id",by.y="gene_id",all.y=T)

#Sig--conglomerate from individuals -- use this!
DE<-read.table("DE_genes_aggregated_annotation.tab",header=TRUE)
DE$sig<-"yes"

data<-merge(DE,genesInRegion,by.x="gene_id",by.y="gene_id",all.y=TRUE)
data$sig[which(is.na(data$sig))]<-"NO"

colsToKeep<-c("gene_id","locus","sig","gene_short_name.y","chromosome","start","end","leg","liver","heart","adult_brain","embryo_brain","lung")
data<-data[,colsToKeep]
#colnames(data)<-c("locus","sig","gene_id","gene_short_name","seqnames","start","end","strand","chromosome")


variables<-c("gene_id","gene_short_name.y","chromosome","start","end","sig","locus")
data.melt<-melt(data,id=variables)
data.melt$value[is.na(data.melt$value)]<-0

#average log2 foldchange... 
means<-aggregate(data.melt,by=list(data.melt$gene_short_name),mean)
means<-means[,c("Group.1","value")]
colnames(means)<-c("name","mean")

#SE
se <- function(x) sqrt(var(x)/length(x))
ses<-aggregate(data.melt,by=list(data.melt$gene_short_name),se)
ses<-ses[,c("Group.1","value")]
colnames(ses)<-c("name","se")

mean_se<-merge(means,ses,by.x="name",by.y="name")
d<-merge(data,mean_se,by.x="gene_short_name.y",by.y="name")
data<-d[,c("gene_id","gene_short_name.y","chromosome","start","end","sig","se","mean")]

limits<-aes(ymin=data$mean-data$se,ymax=data$mean+data$se)


currplot<-ggplot(data,aes(start,mean,color=sig, label=gene_short_name.y))+geom_point(size=3)+scale_color_manual(values=c("black", "red"))+coord_cartesian(xlim=c(-windowSize/2, windowSize/2),ylim=c(-2.5,2.5))+geom_text(data=subset(data, sig=='yes'))+theme_bw()+geom_vline(xintercept=0, color="blue")+geom_hline(yintercept=0,color="blue")+geom_errorbar(limits,width=0.2)


pdf("cis_region_summary_plot_may18.pdf")
currplot
dev.off()

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