#apriori fig stuff

bodymapdir<-"/n/rinn_data1/users/agroff/lincNetwork/mouse/cuffnorm_burge_edited_cuffdiffformat"
alpha<-0.05 
genome<-"mm10"
library(cummeRbund)
library(ggplot2)
#cuff<-readCufflinks(dir=allnobaddir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
bodymap<-readCufflinks(dir=bodymapdir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

#fpkms<-fpkmMatrix(genes(bodymap))
genesOfInterest<-c("Trp53cor1","Cdkn1a","Trp53")
genes<-getGenes(bodymap,genesOfInterest)


genesOfInterest<-c("Trp53cor1","Cdkn1a","LacZ","Trp53")
genes<-getGenes(cuff,genesOfInterest)
genesAnnot<-annotation(genes)
genesFPKMreps<-repFpkm(genes)
geneFpkms<-merge(genesAnnot,genesFPKMreps,by.x="gene_id",by.y="gene_id")
colstokeep<-c("gene_id","gene_short_name","sample_name","replicate","rep_name","fpkm")
gf<-geneFpkms[,colstokeep]
gf_wide<-dcast(gf,rep_name+sample_name~gene_short_name)
gf_wide<-gf_wide[grep("JACKS",gf_wide$rep_name,invert=TRUE),]

library(ggplot2)
library(reshape2)


se <- function(x) sqrt(var(x)/length(x))
gf_mean<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=mean)
gf_std<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=std)
gf_se<-aggregate(gf_wide,by=list(gf_wide$sample_name),FUN=se)



limits<-aes(ymax=gf_mean$Cdkn1a+gf_se$Cdkn1a,ymin=gf_mean$Cdkn1a-gf_se$Cdkn1a)
plot<-ggplot(gf_mean,aes(y=Cdkn1a,x=Trp53cor1))+geom_point()+geom_errorbar(limits,width=0.2)
plot+scale_y_continuous(limits=c(0,300))
fit<-lm(gf_mean$Cdkn1a~gf_mean$Trp53cor1)
summary(fit)$r.squared 


exp<-gf_mean[which(gf_mean$Trp53cor1>1),]
limits<-aes(ymax=gf_mean$Cdkn1a+gf_se$Cdkn1a,ymin=gf_mean$Cdkn1a-gf_se$Cdkn1a)
plot<-ggplot(exp,aes(y=Cdkn1a,x=Trp53cor1,label=Group.1))+geom_point()#+geom_errorbar(limits,width=0.2)

pdf("lincp21_expressed_bodymap.pdf")
plot+scale_y_continuous(limits=c(0,300))+geom_abline(intercept=81.82,slope=28.22)+geom_text()
dev.off()


fit<-lm(exp$Cdkn1a~exp$Trp53cor1)
summary(fit)$r.squared 

#  (Intercept)  exp$Trp53cor1  
# 81.82          28.22



plot<-ggplot(exp,aes(y=Trp53,x=Trp53cor1,label=Group.1))+geom_point()#+geom_errorbar(limits,width=0.2)






genesFpkms<-fpkmMatrix(genes)
genesAnnot<-annotation(genes)
geneNames<-genesAnnot$gene_short_name

Gf<-t(genesFpkms)
colnames(Gf)<-geneNames
Gf<-as.data.frame(Gf)
Gf$names<-row.names(Gf)



#which tissues expressed in

lincp21_expressed<-Gf[which(Gf$Trp53cor1>0.1),]
#106/109 tissues express 
ggplot(lincp21_expressed,aes(names,Trp53cor1))+geom_bar(stat="identity")

lincp21_expressed_high<-Gf[which(Gf$Trp53cor1>1),]
#106/109 tissues express 
ggplot(lincp21_expressed_high,aes(names,Trp53cor1))+geom_bar(stat="identity")




#lincp21-p21 correlation -- DO r^2!!

plot<-ggplot(Gf,aes(Gf$Trp53cor1,Gf$Cdkn1a,label=Gf$names))+geom_point()
+geom_text()
plot<-plot+scale_x_continuous(limits=c(0,1.5))
plot

plot<-ggplot(lincp21_expressed,aes(Trp53cor1,Cdkn1a,label=names))+geom_point()
#+geom_text()
plot<-plot+scale_x_continuous(limits=c(0.1,1))+scale_y_continuous(limits=c(0,300))
plot



nolincp21<-Gf[which(Gf$Trp53cor1<=0.1),]
plot<-ggplot(nolincp21,aes(Trp53cor1,Cdkn1a,label=names))+geom_point()
plot<-plot+scale_x_continuous(limits=c(0,0.1))+scale_y_continuous(limits=c(0,300))
+geom_text()
plot

#Fit 

fit<-lm(Gf$Cdkn1a~Gf$Trp53cor1)
#fit
#(Intercept)  Gf$Trp53cor1  
#48.76         36.51 
summary(fit)$r.squared #0.011714
plot+geom_abline(intercept=48.76, slope=36.51)+scale_y_continuous(limits=c(0,300))
