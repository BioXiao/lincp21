
dat<-read.csv("autoanalysisInfo.csv",header=TRUE,stringsAsFactors=FALSE)
library(knitr)
i<-as.numeric((commandArgs(TRUE)[1]))
filename<-dat$filename[i]
print(filename)
print(dat$strain[i])
dir.create(filename)
setwd(filename)
strain<-dat$strain[i]
timepoint<-dat$sample[i]
tissue<-dat$sample[i]
alpha<-0.05
dir<-dat$dir[i]
#/n/rinn_data2/users/agroff/seq/OtherMice/Lincp21/analysis/SupplementalFileX_Lincp21_StrainTemplate.Rmd
knit2html('/n/rinn_data2/users/agroff/seq/OtherMice/Lincp21/analysis/SupplementalFileX_Lincp21_StrainTemplate.Rmd',output=paste(filename,".md",sep=""), quiet=TRUE)
