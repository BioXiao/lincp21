#lincp21 mult tissues analysis 
#allnobaddir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_conditions_Jacks_norib_noliverko0_ALL_JACKS_norib_noliverko0"
#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_no_bad_everything"
#all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_2_ALL_TISSUES"

#wt_ko_all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_WTvKO_ALL_TISSUES_WTvKO"
wt_ko_all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_WTvKO_ALL_Tissues_Balanced"
sexdiffs<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_KOsexdiffs_KO_sexDiffs"

alpha<-0.05 
genome<-"mm10"
library(cummeRbund)
#cuff<-readCufflinks(dir=allnobaddir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
#cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
cuff<-readCufflinks(dir=wt_ko_all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
cuff<-readCufflinks(dir=sexdiffs,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)


sIDs<-getSig(cuff,alpha)
sigGenes<-getGenes(cuff,sIDs)
sigAnnot<-annotation(sigGenes)

sigMatrix(cuff) 
csDendro(genes(cuff),replicates=TRUE)
csDendro(genes(cuff))

#scatterplots!
fpkms<-fpkmMatrix(genes(cuff))
fpkms$gene_id<-row.names(fpkms)
genesOfInterest<-c("Trp53cor1","Cdkn1a")
genes<-getGenes(cuff,genesOfInterest)
genesAnnot<-annotation(genes)
#geneFpkms<-fpkms[which(fpkms$gene_id %in% genesAnnot$gene_id),]
geneFpkms<-merge(genesAnnot,fpkms,by.x="gene_id",by.y="gene_id")
cnames<-colnames(geneFpkms)
kos<-grep("ko+",cnames,value=TRUE)
wts<-grep("wt+",cnames,value=TRUE)

#kos<-geneFpkms[,kos]
#wts<-geneFpkms[,wts]
#kos$gene_id<-geneFpkms$gene_id
#wts$gene_id<-geneFpkms$gene_id

gf<-geneFpkms

#gf<-rbind(gf,gf)
#gf[3:4,c(kos,wts)]<-log2(gf[3:4,c(kos,wts)])
#gf$type<-c("fpkm","fpkm","log2fpkm","log2fpkm")
forlog<-geneFpkms
#forlog$type<-c("logFoldchange","logFoldchange")
gf[,c(kos,wts)]<-gf[,c(kos,wts)]+0.00000001
forlog[,c(kos,wts)]<-log2(gf[1:2,wts]/gf[1:2,kos])
#gf<-rbind(gf,forlog)

unneeded<-c("gene_id","class_code","nearest_ref_id","locus","length","coverage")
#gf[,unneeded]<-NULL
##MAKE THIS WORK

gf$gene_id<-NULL
gf$class_code<-NULL
gf$nearest_ref_id<-NULL
gf$locus<-NULL
gf$length<-NULL
gf$coverage<-NULL
forlog$gene_id<-NULL
forlog$class_code<-NULL
forlog$nearest_ref_id<-NULL
forlog$locus<-NULL
forlog$length<-NULL
forlog$coverage<-NULL
g<-as.matrix(gf)
l<-as.matrix(forlog)
gt<-t(g)
lt<-t(l)
fpkmSet<-as.data.frame(gt)
logSet<-as.data.frame(lt)
colnames(fpkmSet)<-c("Cdkn1aFpkm","Trp53cor1Fpkm")
fpkmSet<-fpkmSet[-1,]
colnames(logSet)<-c("Cdkn1aLogFold","Trp53cor1LogFold")
logSet<-logSet[-1,]

##FIGURE OUT BETTER WAY TO DO ALL THAT AND THIS: 


fpkmSet$Cdkn1aFpkm<-as.numeric(as.character(fpkmSet$Cdkn1aFpkm))
fpkmSet$Trp53cor1Fpkm<-as.numeric(as.character(fpkmSet$Trp53cor1Fpkm))
logSet$Cdkn1aLogFold<-as.numeric(as.character(logSet$Cdkn1aLogFold))
logSet$Trp53cor1LogFold<-as.numeric(as.character(logSet$Trp53cor1LogFold))

foldchange<-fpkmSet$Cdkn1aFpkm[1:6]/fpkmSet$Cdkn1aFpkm[7:12]

data<-cbind(fpkmSet,logSet)
data<-data[1:6,]
data$names<-row.names(data)
data<-droplevels(data)
data$Cdkn1aFoldchange<-foldchange

library(ggplot2)
#log2foldchange
logplot<-ggplot(data,aes(data$Trp53cor1Fpkm,data$Cdkn1aLogFold,label=names))+geom_point()+geom_text()
logplot
#logplot<-logplot+scale_x_continuous(limits=c(0,1.5))+scale_y_continuous(limits=c(0,50))
#logplot



#foldchange
plot<-ggplot(data,aes(data$Trp53cor1Fpkm,data$Cdkn1aFoldchange,label=names))+geom_point()+geom_text()
plot<-plot+scale_x_continuous(limits=c(0,1.5))
plot


library(plyr)
gf$class_code<-NULL
gf$nearest_ref_id<-NULL
gf$length<-NULL
gf$coverage<-NULL
gf$locus<-NULL
gf_melt<-melt(gf,id=c("gene_short_name","type"))
gf2<-dcast(gf_melt,type~gene_short_name)



sigIDs<-getSig(cuff,alpha=0.05)
#By default getSig() outputs a vector of tracking IDs corresponding to all genes that reject the null hypothesis in any condition tested - See more at: http://compbio.mit.edu/cummeRbund/manual_2_0.html#sthash.EbnJB44Q.dpuf
#collect sig from all pairwise comparisons
#overlap

sigTable<-getSigTable(cuff,alpha=0.05)
dat<-as.data.frame(sigTable)
data<-dat
comparisons<-colnames(dat)
comparisons

#Common Genes 
wtvkos<-c(3,25,33,41,51,63)
d<-dat[,wtvkos]
d$sum=rowSums(d,na.rm=TRUE)
common=d[which(d$sum>=5),]
commonIDs<-row.names(common)
commonGenes<-getGenes(cuff,commonIDs)
commonAnnot<-annotation(commonGenes)





#Local always DE 
one<-strsplit(commonAnnot$locus,":",2)
chr<-sapply(one,"[[",1)
pos<-sapply(one,"[[",2)
two<-strsplit(pos,"-",2)
start<-sapply(two,"[[",1)
end<-sapply(two,"[[",2)

CommonLoci<-cbind(commonAnnot$gene_id,commonAnnot$gene_short_name,chr,start,end)
commonloci<-as.data.frame(CommonLoci)

genesdiff<-diffTable(commonGenes)
colNames<-colnames(genesdiff)
lognames<-grep("log2_fold_change+",colNames,value=TRUE)
wt<-grep("wt+",lognames,value=TRUE)
ko<-grep("ko+",wt,value=TRUE)
comparisons<-c(36,29,22,15,8,1)
comp<-ko[comparisons]
diffcomparisons<-genesdiff[,comp]
diffcomparisons$gene_id<-genesdiff$gene_id
cl<-merge(commonloci,diffcomparisons,by.x="V1",by.y="gene_id")
commonloci<-cl

#chr17 only 
local<-commonloci[which(commonloci$chr=="chr17"),]
#log2(foldchange)

#subtract lincRNA!! 
lincp21<-getGene(cuff,"Trp53cor1")
lincp21annot<-annotation(lincp21)
lincp21_start<-29057473
local$start<-droplevels(local$start)
local$start<-as.numeric(as.character(local$start))
local$start<-local$start-lincp21_start
windowSize<-4000000

#local$ko_leg_wt_leg_log2_fold_change<-as.numeric(as.character(local$ko_leg_wt_leg_log2_fold_change))

lsubset<-local
lsubset[,4:11]<-apply(local[,4:11],2,function(x){as.numeric(as.character(x))})
local<-lsubset

cond<-colnames(local)
makeplot<-function(x){
  print(x)
  currplot<-ggplot(local,aes_string("start",x, label="V2"))
  currplot<-currplot+geom_point(size=3)
  currplot<-currplot+labs(title="Local Summary")
  #currplot<-currplot+coord_cartesian(xlim=c(-windowSize/2, windowSize/2),ylim=c(-max(abs(as.numeric(local$ko_leg_wt_leg_log2_fold_change)))-1,max(abs(as.numeric(local$ko_leg_wt_leg_log2_fold_change)))+1))
  currplot+theme_bw()+geom_vline(xintercept=0, color="blue")+geom_hline(yintercept=0,color="blue")+geom_text()
}




makeplot(cond[6])
makeplot(cond[7])
makeplot(cond[8])
makeplot(cond[9])
makeplot(cond[10])
makeplot(cond[11])

 indecies<-seq(6,11)
for(i in indecies){
  makeplot(cond[i])
  readline()
}



##ever strand info???? 

#universe of genes
universe<-d[which(d$sum>0),]
uniIDS<-row.names(universe)
univGenes<-getGenes(cuff,uniIDS)
universeAnnot<-annotation(univGenes)



#Local Sig Genes (any condition)
library(seqbias)
library(stringr)
library(plyr)

getTable<-function(object){
  fullTable<-diffTable(genes(object))
  write("First Split",stderr())
  firstSplit<-str_split_fixed(fullTable$locus,":",2)
  write("Second Split",stderr())
  secondSplit<-str_split_fixed(firstSplit[,2],"-",2)
  fullTable$chromosome<-firstSplit[,1]
  fullTable$start<-as.numeric(secondSplit[,1])
  fullTable$end<-as.numeric(secondSplit[,2])
  fullTable<-fullTable[fullTable$chromosome %in% names(seqlengths(mm10.granges)),]
  fullTable$chromosome<-factor(fullTable$chromosome, levels=names(seqlengths(mm10.granges)))
  fullTable
}
fullTable<-getTable(cuff)
write.table(fullTable, file="all_fullTable.tab",sep="\t")

write("CAN END NOW",stderr())
#Global GO (universe of DE genes)


#network? 

fpkms<-fpkmMatrix(genes(cuff))
fpkms$sum<-rowSums(fpkms,na.rm=TRUE)
expressed<-fpkms[which(fpkms$sum!=0),]
wtfpkms<-expressed[,1:6]
kofpkms<-expressed[,7:12]
diffs<-wtfpkms-kofpkms
library(WGCNA)
library(bigmemory)
allowWGCNAThreads()

c<-corAndPvalue(t(diffs))





#FOR OLD SET 
contrasts<-1,13,19,27
exclude<-c(28,24,22,21,17,12,10,9,8,7,6,5)
ex<-comparisons[exclude]
d<-dat[,c("JACKS_mef_wt_nodoxvsJACKS_mef_ko_nodox","wt_heartvsko_heart","wt_legvsko_leg","wt_livervsko_liver")]
#jacks mef wt v ko, heart, leg, liver,
dat<-d
dat$sum<-rowSums(dat,na.rm=TRUE)

excludeDat<-dat[,ex]
excludeDat$sum<-rowSums(excludeDat,na.rm=TRUE)


common<-dat[which(dat$sum==4),] #2genes 
common<-dat[which(dat$sum>=3),]
commonIDs<-row.names(common)
commonGenes<-getGenes(cuff,commonIDs)
commonAnnot<-annotation(commonGenes)

geneNames<-commonAnnot$gene_short_name


geneNames<-universeAnnot$gene_short_name

library(cummeRbund)
library(xtable)
library(limma)
library(GSA)
library(gplots)
library(marray)
library(ggplot2)
library(gtable)
library(gridExtra)
library(RColorBrewer)
library(RMySQL)


#source("http://bioconductor.org/biocLite.R")
#biocLite("ReactomePA")

library(ReactomePA)
library(DOSE)

#sigGeneIDs<-getSig(cuff, alpha=alpha)
#sigGenes<-getGenes(cuff,sigGeneIDs)
#geneAnnot<-annotation(sigGenes)
#geneNames<-geneAnnot$gene_short_name
#sigDiff<-diffData(commonGenes)
sigDiff<-diffData(univGenes)
sigDiff$foldChange<-sigDiff$value_1/sigDiff$value_2

library(clusterProfiler)
require(biomaRt)

ensembl <- useMart("ENSEMBL_MART_ENSEMBL","mmusculus_gene_ensembl", 
                   host="www.ensembl.org")
#ensembl <- useMart("ENSEMBL_MART_ENSEMBL","mmusculus_gene_ensembl", 
#                   host="www.biomart.org")

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
kegg<-enrichKEGG(gene=sigEZ, organism="mouse",pvalueCutoff=1, readable=T)
pathway<-enrichPathway(gene=sigEZ,organism="mouse",pvalueCutoff=0.01, readable=T)
plot(goBP,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched BP")+theme_bw()
plot(goMF,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched MF")+theme_bw()
plot(goCC,showCategory=20) + theme(axis.text.x=element_text(angle=-90,hjust=0)) + ggtitle("Enriched CC")+theme_bw()
plot(kegg, showCategory=20) + ggtitle("Kegg Pathways")+theme_bw()
plot(pathway,showCategory=20) + ggtitle("Reactome pathway enrichment")+theme_bw()
detach("package:biomaRt")


#GSEA UNIVERSE


#anything that changes wt to ko


universe<-dat[which(dat$sum>0),]
ids<-row.names(universe)
genes<-getGenes(cuff,ids)
genesAnnot<-annotation(genes)
geneNames<-genesAnnot$gene_short_name
sigDiff<-diffData(genes)
sigDiff$foldChange<-sigDiff$value_1/sigDiff$value_2
