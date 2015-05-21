# Generate all wt-v-ko analysis reports for whole brain sequencing by strain 
# NEED:
# strain
# timepoint
# dir
# filename
# # make csv file with these and feed into R BATCH script 

diffdir<-"/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1/"

dat=matrix
names<-c("strain","sample","filename","dir")
heart<-c("Trp53cor1","Heart","Trp53cor_E145_Heart","/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_HEART")
liver<-c("Trp53cor1","Liver","Trp53cor_E145_Liver","/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_LIVER")
rib<-c("Trp53cor1","Rib","Trp53cor_E145_Rib","/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/diff/Trp53cor1_E14.5_RIB")

dat<-rbind(names,heart,liver,rib)
write.table(dat,"autoanalysisInfo.csv",sep=",")


####################BATCH SCRIPT######################
dat<-read.csv("autoanalysisInfo.csv",header=TRUE,stringsAsFactors=FALSE)


