#Figure1 PDF for editing and lab meeting

all<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_no_bad_everything"
alpha<-0.05 
genome<-"mm10"
library(cummeRbund)
library(reshape2)
#cuff<-readCufflinks(dir=allnobaddir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
cuff<-readCufflinks(dir=all,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

#scatterplots!
fpkms<-fpkmMatrix(genes(cuff))
fpkms$gene_id<-row.names(fpkms)
genesOfInterest<-c("Trp53cor1","Cdkn1a","LacZ","Trp53")
genes<-getGenes(cuff,genesOfInterest)
genesAnnot<-annotation(genes)
genesFPKMreps<-repFpkm(genes)
geneFpkms<-merge(genesAnnot,genesFPKMreps,by.x="gene_id",by.y="gene_id")
colstokeep<-c("gene_id","gene_short_name","sample_name","replicate","rep_name","fpkm")
gf<-geneFpkms[,colstokeep]
gf_wide<-dcast(gf,rep_name+sample_name~gene_short_name)
gf_wide<-gf_wide[grep("JACKS",gf_wide$rep_name,invert=TRUE),]

se <- function(x) sqrt(var(x)/length(x))
gf_mean<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=mean)
gf_std<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=std)
gf_se<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=se)



library(ggplot2)

#p21-lincp21
wtavg<-gf_mean[grep("wt",gf_mean$Group.1),]
wtse<-gf_se[grep("wt",gf_se$Group.1),]
limits<-aes(ymax=wtavg$Cdkn1a+wtse$Cdkn1a,ymin=wtavg$Cdkn1a-wtse$Cdkn1a)
plot<-ggplot(wtavg,aes(y=Cdkn1a,x=Trp53cor1))+geom_point()+geom_errorbar(limits,width=0.2)
plot

#Fit 
fit<-lm(wtavg$Cdkn1a~wtavg$Trp53cor1)
summary(fit)$r.squared #0.4674
#Call:
#  lm(formula = gf_mean$Cdkn1a ~ gf_mean$Trp53cor1)
#Coefficients:
#  (Intercept)  gf_mean$Trp53cor1  
#   10.87            19.64


#p53-lincp21
limits<-aes(ymax=wtavg$Trp53+wtse$Trp53,ymin=wtavg$Trp53-wtse$Trp53)
plot<-ggplot(wtavg,aes(y=Trp53,x=Trp53cor1,label=Group.1))+geom_point()+geom_text()+geom_errorbar(limits,width=0.2)
plot

#p53-p21
plot<-ggplot(wtavg,aes(y=Trp53,x=Cdkn1a,label=Group.1))+geom_point()+geom_text()+geom_errorbar(limits,width=0.2)
plot


limits<-aes(ymax=wtavg$Cdkn1a+wtse$Cdkn1a,ymin=wtavg$Cdkn1a-wtse$Cdkn1a)
plot<-ggplot(wtavg,aes(y=Cdkn1a,x=Trp53cor1,label=Group.1))+geom_point()+geom_text()+geom_errorbar(limits,width=0.2)
plot



pdf("P21-lincp21_scatter.pdf")
plot+geom_abline(intercept=10.87, slope=19.64)+theme_bw()
dev.off()


#foldchange p21-lincp21
#foldchange p21-p21
#foldchange WT over KO: 
foldchange<-gf_mean[6:10,3:6]/gf_mean[1:5,3:6]
logfoldchange<-log2(foldchange)
logfoldchange$sample_name<-gf_mean$Group.1[grep("wt",gf_mean$Group.1)]
#foldchange<-gf_mean[grep("ko",gf_mean$Group.1),3:6]/gf_mean[grep("wt",gf_mean$Group.1),3:6]
data<-wtavg
data$p21_logfoldchange<-logfoldchange$Cdkn1a
#foldchange p21-lincp21
logplot<-ggplot(data,aes(Trp53cor1,p21_logfoldchange,label=Group.1))+geom_point()+geom_text()
fit<-lm(data$p21_logfoldchange~data$Trp53cor1)
#  (Intercept)  data$Trp53cor1  
# 2.8554         -0.9795 
summary(fit)$r.squared # 0.04998637
pdf("logfoldchange_p21_lincp21.pdf")
logplot+geom_abline(intercept=2.8554, slope=-0.9795)+theme_bw()
dev.off()


#foldchange p21-p21
plot<-ggplot(data,aes(Cdkn1a,p21_logfoldchange,label=Group.1))+geom_point()+geom_text()
fit<-lm(data$p21_logfoldchange~data$Cdkn1a)
#(Intercept)  data$Cdkn1a  
# 1.51098      0.05441
summary(fit)$r.squared #0.12723


pdf("logfoldchange_p21_p21.pdf")
plot+geom_abline(intercept=1.51098, slope=0.05441)+theme_bw()
dev.off()
