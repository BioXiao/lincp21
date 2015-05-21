# exploring lincp21 seq en masse
JACKS_alldir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/JACKS_Mef_ALL_treated_and_untreated"
JACKS_doxdir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/JACKS_Mef_treated"
JACKS_nodoxdir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/JACKS/diff/JACKS_Mef_untreated"

#All_conditions_Jacks_norib_noliverko0_ALL_JACKS_norib_noliverko0
allnobaddir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_conditions_Jacks_norib_noliverko0_ALL_JACKS_norib_noliverko0"

heart_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_HEART"
liver_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_LIVER"
rib_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_RIB"
muscle_dir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1"
brain_dir_adult<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Adult"
brain_dir_embryo<-"/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor1_vs_WT_Embryonic/"
alpha<-0.05 
genome<-"mm10"

library(cummeRbund)


heart<-readCufflinks(dir=heart_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
liver<-readCufflinks(dir=liver_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
rib<-readCufflinks(dir=rib_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
muscle<-readCufflinks(dir=muscle_dir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
brain_embryo<-readCufflinks(dir=brain_dir_embryo,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
brain_adult<-readCufflinks(dir=brain_dir_adult,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
cuff<-readCufflinks(dir=allnobaddir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
JACKS_all<-readCufflinks(dir=JACKS_alldir[1],gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
JACKS_dox<-readCufflinks(dir=JACKS_doxdir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
JACKS_nodox<-readCufflinks(dir=JACKS_nodoxdir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
WTonlydir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/WT_TISSUES_ALL"
ALLdir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_Conditions_ALL"
ALLandJacksdir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/All_conditions_Jacks_ALL_JACKS"
WTonly<-readCufflinks(dir=WTonlydir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
ALL<-readCufflinks(dir=ALLdir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)
ALL_jacksincluded<-readCufflinks(dir=ALLandJacksdir,gtfFile="/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf",genome=genome)

sig<-getSig(WTonly)
sigMatrix(WTonly)

p21_heart<-getGene(heart,"Cdkn1a")
p21_liver<-getGene(liver,"Cdkn1a")
p21_rib<-getGene(rib,"Cdkn1a")
p21_muscle<-getGene(muscle,"Cdkn1a")
p21_brain_embryo<-getGene(brain_embryo,"Cdkn1a")
p21_brain_adult<-getGene(brain_adult,"Cdkn1a")

p21_heart_fpkms<-fpkmMatrix(p21_heart)
p21_liver_fpkms<-fpkmMatrix(p21_liver)
p21_rib_fpkms<-fpkmMatrix(p21_rib)
p21_muscle_fpkms<-fpkmMatrix(p21_muscle)
p21_brain_e_fpkms<-fpkmMatrix(p21_brain_embryo)
p21_brain_a_fpkms<-fpkmMatrix(p21_brain_adult)

p21_vals<-cbind(c(p21_heart_fpkms,p21_liver_fpkms,p21_rib_fpkms,p21_muscle_fpkms,p21_brain_e_fpkms,p21_brain_a_fpkms))
p21_WTS<-p21_vals[which(row.names(p21_vals)=="WT"),]
p21_WTS<-unlist(p21_WTS)
p21_KOs<-p21_vals[which(row.names(p21_vals)!="WT"),]
p21_KOs<-unlist(p21_KOs)

lincp21_heart<-getGene(heart,"Trp53cor1")
lincp21_liver<-getGene(liver,"Trp53cor1")
lincp21_rib<-getGene(rib,"Trp53cor1")
lincp21_muscle<-getGene(muscle,"Trp53cor1")
lincp21_brain_embryo<-getGene(brain_embryo,"Trp53cor1")
lincp21_brain_adult<-getGene(brain_adult,"Trp53cor1")

lincp21_heart_fpkm<-fpkmMatrix(lincp21_heart)$WT
lincp21_liver_fpkm<-fpkmMatrix(lincp21_liver)$WT
lincp21_rib_fpkm<-fpkmMatrix(lincp21_rib)$WT
lincp21_muscle_fpkm<-fpkmMatrix(lincp21_muscle)$WT
lincp21_brain_embryo_fpkm<-fpkmMatrix(lincp21_brain_embryo)$WT
lincp21_brain_adult_fpkm<-fpkmMatrix(lincp21_brain_adult)$WT

lincp21_values<-c(lincp21_heart_fpkm,lincp21_liver_fpkm,lincp21_rib_fpkm,lincp21_muscle_fpkm,lincp21_brain_embryo_fpkm,lincp21_brain_adult_fpkm)


LZ_heart<-getGene(heart,"LacZ")
LZ_liver<-getGene(liver,"LacZ")
LZ_rib<-getGene(rib,"LacZ")
LZ_muscle<-getGene(muscle,"LacZ")
LZ_brain_embryo<-getGene(brain_embryo,"LacZ")
LZ_brain_adult<-getGene(brain_adult,"LacZ")



lz_heart_fpkm<-fpkmMatrix(LZ_heart)$Trp53cor
lz_liver_fpkm<-fpkmMatrix(LZ_liver)$Trp53cor
LZ_rib_fpkm<-fpkmMatrix(LZ_rib)$Trp53cor
LZ_muscle_fpkm<-fpkmMatrix(LZ_muscle)$Trp53cor
LZ_brain_embryo_fpkm<-fpkmMatrix(LZ_brain_embryo)$Trp53cor
LZ_brain_adult_fpkm<-fpkmMatrix(LZ_brain_adult)$Trp53cor

LZ_values<-c(lz_heart_fpkm,lz_liver_fpkm,LZ_rib_fpkm,LZ_muscle_fpkm,LZ_brain_embryo_fpkm,LZ_brain_adult_fpkm)
samples<-c("heart","liver","rib","leg","brain_embryo","brain_adult")

dat<-as.data.frame(cbind(samples,LZ_values,lincp21_values,p21_WTS,p21_KOs))
row.names(dat)<-samples
colnames(dat)<-c("sampleNames","LZ","lincp21","p21","p21_ko")
d<-as.data.frame(cbind(LZ_values,lincp21_values,p21_WTS,p21_KOs))
colnames(d)<-c("LZ","lincp21","p21","p21_KOs")
row.names(d)<-samples
d$names<-samples

library(ggplot2)
#ggplot(dat,aes(x=LZ,y=lincp21))+geom_point()
p<-ggplot(d,aes(x=lincp21,y=p21,label=d$names))
p<-ggplot(d,aes(x=LZ))
#p+geom_point(aes(y=d$p21))+geom_text()

p+geom_point()+geom_point(aes(y=d$p21_KOs,color='p21 KO',label=d$names))+geom_text()

p+geom_point(aes(y=d$LZ,color='LZ'))

+geom_point(aes(y=d$p21_KOs, color='p21 KO'))

#lz-p21in KO v linp21-p21 in wt 
p<-ggplot(d,aes(x=lincp21,y=p21,label=d$names))+geom_point()
p+geom_point(aes(x=d$LZ,y=d$p21_KOs,color='p21 KO',label=d$names))+geom_text()

ggplot(d,aes(x=d$LZ,y=d$p21_KOs,color='p21 KO',label=d$names))+geom_text()



#+geom_point(aes(y=dat$lincp21))

plot(data$LZ_values,data$lincp21_values)
plot(data$lincp21_values,data$p21_WTS)
plot(data$LZ_values,data$p21_KOs)
plot(data$LZ_values,data$p21_KOs)

expressionBarplot(LZ_heart)
expressionBarplot(LZ_liver)
expressionBarplot(LZ_rib)
expressionBarplot(LZ_muscle)
expressionBarplot(LZ_brain_embryo)
expressionBarplot(LZ_brain_adult)


expressionBarplot(p21_heart)
expressionBarplot(p21_liver)
expressionBarplot(p21_rib)
expressionBarplot(p21_muscle)
expressionBarplot(p21_brain_embryo)
expressionBarplot(p21_brain_adult)

expressionBarplot(lincp21_heart)
expressionBarplot(lincp21_liver)
expressionBarplot(lincp21_rib)
expressionBarplot(lincp21_muscle)
expressionBarplot(lincp21_brain_embryo)
expressionBarplot(lincp21_brain_adult)

#lacZ 

actb_rib<-getGene(rib,"Actb")
Myod_rib<-getGene(rib,"Myod1")
sigMatrix(genes(rib))
#look closer at reps


