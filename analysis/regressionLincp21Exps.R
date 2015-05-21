# regression playtimes, with lincp21 data 
# for figure 5 

library(cummeRbund)
library(gplots)
library(plyr)

all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/BROAD_ALL_3_ALL_TISSUES"
alpha<-0.05 
genome<-"mm10"
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

getRelevantSigTable<-function(cuff,alpha){
  m<-getSigTable(cuff,alpha)
  comparisons<-c("wt_brain_adultvsko_brain_adult","wt_brain_embryovsko_brain_embryo","wt_heartvsko_heart","wt_legvsko_leg","wt_livervsko_liver","wt_lungvsko_lung")
  m<-m[,comparisons]
  m<-as.data.frame(m)
  m$sum<-rowSums(m,na.rm=TRUE)
  m
}
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


# play with::
# lm()
# I()(to center data etc) --> wont really play with this here... but good to know
# predict()
# summary(fit)
# resid()
#



genesOfInterest<-c("Trp53cor1","LacZ","Trp53","Cdkn1a","Glo1","Rnps1","Gm9825")
genes<-getGenes(cuff,genesOfInterest)
genesAnnot<-annotation(genes)
genesFPKMreps<-repFpkm(genes)
geneFpkms<-merge(genesAnnot,genesFPKMreps,by.x="gene_id",by.y="gene_id")
colstokeep<-c("gene_id","gene_short_name","sample_name","replicate","rep_name","fpkm")
gf<-geneFpkms[,colstokeep]
gf_wide<-dcast(gf,rep_name+sample_name~gene_short_name)
se <- function(x) sqrt(var(x)/length(x))
gf_mean<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=mean)
gf_se<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=se)
wtavg<-gf_mean[grep("wt",gf_mean$Group.1),]
wtse<-gf_se[grep("wt",gf_se$Group.1),]

#p21-lincp21

limits<-aes(ymax=wtavg$Cdkn1a+wtse$Cdkn1a,ymin=wtavg$Cdkn1a-wtse$Cdkn1a)
plot<-ggplot(wtavg,aes(y=Cdkn1a,x=Trp53cor1,label=Group.1))+geom_point()+geom_errorbar(limits,width=0.2)+geom_text()+theme_bw()

#Fit 
fit<-lm(wtavg$Cdkn1a~wtavg$Trp53cor1) #how well is p21 predicted by lincp21? assuming linear relationship. 
#summary(fit)
#summary(fit)$r.squared #0.5284

pdf("p21-lincp21_expression_cor.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=10,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()

###ADD TRENDLINES !!

#Glo1-lincp21
fit<-lm(wtavg$Glo1~wtavg$Trp53cor1)
limits<-aes(ymax=wtavg$Glo1+wtse$Glo1,ymin=wtavg$Glo1-wtse$Glo1)
plot<-ggplot(wtavg,aes(y=Glo1,x=Trp53cor1,label=Group.1))+geom_point()+geom_errorbar(limits,width=0.2)+geom_text()+theme_bw()
pdf("glo-lincp21_expression_cor.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=10,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()



#Gm9825-lincp21
fit<-lm(wtavg$Gm9825~wtavg$Trp53cor1)
limits<-aes(ymax=wtavg$Gm9825+wtse$Gm9825,ymin=wtavg$Gm9825-wtse$Gm9825)
plot<-ggplot(wtavg,aes(y=Gm9825,x=Trp53cor1,label=Group.1))+geom_point()+geom_errorbar(limits,width=0.2)+geom_text()+theme_bw()
pdf("Gm9825-lincp21_expression_cor.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=10,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()



#KO_Lacz-lincp21
#GET KOavg
#koavg<-gf_mean[grep("ko",gf_mean$Group.1),]
#kose<-gf_se[grep("ko",gf_se$Group.1),]
#limits<-aes(ymax=koavg$LacZ+kose$LacZ,ymin=koavg$LacZ-kose$LacZ)
#plot<-ggplot(koavg,aes(y=LacZ,x=wtavg$Trp53cor1,label=Group.1))+geom_point()+geom_errorbar(limits,width=0.2)+geom_text()+theme_bw()


#Rnps1-lincp21
fit<-lm(wtavg$Rnps1~wtavg$Trp53cor1)
limits<-aes(ymax=wtavg$Rnps1+wtse$Rnps1,ymin=wtavg$Rnps1-wtse$Rnps1)
plot<-ggplot(wtavg,aes(y=Rnps1,x=Trp53cor1,label=Group.1))+geom_point()+geom_errorbar(limits,width=0.2)+geom_text()+theme_bw()
pdf("Rnps1-lincp21_expression_cor.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=10,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()




#m<-getRelevantSigTable(cuff,alpha)
#alwaysSig<-m[which(m$sum==6),]
#alwaysSigGenes<-getGenes(cuff,row.names(alwaysSig))
#alwaysSigGenes<-annotation(alwaysSigGenes)$gene_short_name
#genesOfInterest<-c("Trp53cor1","LacZ","Trp53",alwaysSigGenes)
fc<-getLogFoldChangeTable(cuff)
fc$gene_id<-row.names(fc)
annot<-annotation(genes(cuff))
annot<-ddply(annot,.(gene_id),head,n=1)
a<-annot[,c("gene_id","gene_short_name")]
dat<-merge(a,fc,by.x="gene_id",by.y="gene_id")
genesOfInterest<-c("Trp53cor1","LacZ","Trp53","Cdkn1a","Glo1","Rnps1","Gm9825")
fcGenesofInterest<-dat[which(dat$gene_short_name %in% genesOfInterest),]
dat.melt<-melt(fcGenesofInterest,id.vars=c("gene_id","gene_short_name"))
dat.cast<-dcast(dat.melt,variable~gene_short_name)
genes<-getGenes(cuff,genesOfInterest)
genesAnnot<-annotation(genes)
genesFPKMreps<-repFpkm(genes)
geneFpkms<-merge(genesAnnot,genesFPKMreps,by.x="gene_id",by.y="gene_id")
colstokeep<-c("gene_id","gene_short_name","sample_name","replicate","rep_name","fpkm")
gf<-geneFpkms[,colstokeep]
gf_wide<-dcast(gf,rep_name+sample_name~gene_short_name)

se <- function(x) sqrt(var(x)/length(x))
gf_mean<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=mean)
#gf_std<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=std)
gf_se<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=se)


wtavg<-gf_mean[grep("wt",gf_mean$Group.1),]
lincp21_exps<-wtavg[,c("Group.1","Trp53cor1")]
lincp21_exps$Group.1<-gsub("wt_","",lincp21_exps$Group.1)
lincp21_exps$Group.1<-gsub("brain_adult","adult_brain",lincp21_exps$Group.1)
lincp21_exps$Group.1<-gsub("brain_embryo","embryo_brain",lincp21_exps$Group.1)
colnames(lincp21_exps)<-c("sample","WT_lincp21_FPKMavg")
dat<-merge(dat.cast,lincp21_exps,by.x="variable",by.y="sample")

#p21-lincp21
fit<-lm(dat$Cdkn1a~dat$WT_lincp21_FPKMavg)
plot<-ggplot(dat,aes(y=Cdkn1a,x=WT_lincp21_FPKMavg,label=variable))+geom_point()+geom_text()+theme_bw()
pdf("p21-lincp21_foldchange.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=-4,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off() 


#Glo1-lincp21
fit<-lm(dat$Glo1~dat$WT_lincp21_FPKMavg)
plot<-ggplot(dat,aes(y=Glo1,x=WT_lincp21_FPKMavg,label=variable))+geom_point()+geom_text()+theme_bw()
pdf("glo-lincp21_foldchange.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=1,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()



#Gm9825-lincp21
fit<-lm(dat$Gm9825~dat$WT_lincp21_FPKMavg)
plot<-ggplot(dat,aes(y=Gm9825,x=WT_lincp21_FPKMavg,label=variable))+geom_point()+geom_text()+theme_bw()
pdf("Gm9825-lincp21_foldchange.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=2,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()



#KO_Lacz-lincp21
#GET KOavg
#plot<-ggplot(dat,aes(y=LacZ,x=WT_lincp21_FPKMavg,label=variable))+geom_point()+geom_text()+theme_bw()
#plot

#Rnps1-lincp21
fit<-lm(dat$Rnps1~dat$WT_lincp21_FPKMavg)
plot<-ggplot(dat,aes(y=Rnps1,x=WT_lincp21_FPKMavg,label=variable))+geom_point()+geom_text()+theme_bw()
pdf("Rnps-lincp21_folchange.pdf")
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=0.5,y=-1,label=paste("r^2=",summary(fit)$r.squared,sep=""))
dev.off()


###############################################################

# More plots!

#what about glo-p21? 
# expression:
fit<-lm(wtavg$Glo1~wtavg$Cdkn1a)
limits<-aes(ymax=wtavg$Glo1+wtse$Glo1,ymin=wtavg$Glo1-wtse$Glo1)
plot<-ggplot(wtavg,aes(y=Glo1,x=Cdkn1a,label=Group.1))+geom_point()+geom_errorbar(limits,width=2)+geom_text()+theme_bw()
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=10,y=50,label=paste("r^2=",summary(fit)$r.squared,sep=""))


# foldchange: 
fit<-lm(dat$Glo1~wtavg$Cdkn1a)
plot<-ggplot(dat,aes(y=Glo1,x=wtavg$Cdkn1a,label=variable))+geom_point()+geom_text()+theme_bw()
plot+stat_smooth(method="lm",se=FALSE, fullrange=TRUE)+annotate("text",x=10,y=1,label=paste("r^2=",summary(fit)$r.squared,sep=""))
