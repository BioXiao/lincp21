library(ggplot2)
library(grid)


#############
#Utility Functions
#############
# multiplot <- function(..., plotlist=NULL, cols) {
#     require(grid)
# 
#     # Make a list from the ... arguments and plotlist
#     plots <- c(list(...), plotlist)
# 
#     numPlots = length(plots)
# 
#     # Make the panel
#     plotCols = cols                          # Number of columns of plots
#     plotRows = ceiling(numPlots/plotCols) # Number of rows needed, calculated from # of cols
# 
#     # Set up the page
#     grid.newpage()
#     pushViewport(viewport(layout = grid.layout(plotRows, plotCols)))
#     vplayout <- function(x, y)
#         viewport(layout.pos.row = x, layout.pos.col = y)
# 
#     # Make each plot, in the correct location
#     for (i in 1:numPlots) {
#         curRow = ceiling(i/plotCols)
#         curCol = (i-1) %% plotCols + 1
#         print(plots[[i]], vp = vplayout(curRow, curCol ))
#     }
# 
# }

################
#Main
################

###General ggplot2 options
#theme_set(theme_bw())
#theme_set(theme_gray())
pmargin_top <- theme(plot.margin = unit(c(1, 1,-0.5, 0), "lines"))
pmargin_middle <-theme(plot.margin = unit(c(0, 1,-1, 2.5), "lines"))
pmargin_bottom <-theme(plot.margin = unit(c(0, 1,0, 0.5), "lines"))
major_grid <- theme(panel.grid = element_blank(),panel.background = element_blank())
no_breaks_x <- scale_x_continuous(breaks=NULL)
no_breaks_y <- scale_y_continuous(breaks=NULL)

makeGSEAplot<-function(genesetData,filename=NULL,title=NULL,zeroCross=c(),...){
  RankedListMax<-max(abs(genesetData$RANK.METRIC.SCORE))
  
  p<-ggplot(genesetData)
  
  p1<- p + geom_line(aes(x=RANK.IN.GENE.LIST,y=RUNNING.ES),col="red") + geom_hline(yintercept=0,lty='dashed') + no_breaks_x + major_grid + xlab(NULL) + ylab("Enrichment Score") + pmargin_top + scale_y_continuous(limits=c(-1,1))
  
  if(!is.null(title)){
    p1 <-p1 + ggtitle(title)
  }
  
  p2<- p + geom_linerange(aes(x=RANK.IN.GENE.LIST,ymin=0,ymax=1)) + no_breaks_x + no_breaks_y + major_grid + xlab(NULL) + ylab(NULL) + pmargin_middle
  
  p3<- p + stat_density(aes(x=RANK.IN.GENE.LIST,y=1,fill=..density..),geom="tile",position="identity") + xlab(NULL) + ylab(NULL) + scale_fill_gradient(low="white",high="steelblue") + theme(legend.position = "none") + no_breaks_x + no_breaks_y + major_grid + pmargin_middle
  
  p4<- p + geom_area(aes(x=RANK.IN.GENE.LIST,y=RANK.METRIC.SCORE),fill='grey') + ylab("Ranked List Metric") + xlab('Rank in Gene List')+ pmargin_bottom + major_grid + scale_y_continuous(limits=c(-RankedListMax,RankedListMax))
  
  for (zc in zeroCross){
    p1<-p1 + geom_vline(xintercept = zc,color="darkgrey",linetype="dashed")
    p2<-p2 + geom_vline(xintercept = zc,color="darkgrey",linetype="dashed")
    p3<-p3 + geom_vline(xintercept = zc,color="darkgrey",linetype="dashed")
    p4<-p4 + geom_vline(xintercept = zc,color="darkgrey",linetype="dashed")
  }
  
  #multiplot(p1, p2, p3, cols=1)
  if(!is.null(filename)){
    pdf(filename,...)
  }
  #OR
  grid.newpage()
  pushViewport(viewport(layout=grid.layout(4,1,heights = unit(c(4, 0.5,0.5, 3),"null"))))
  print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))         
  print(p2, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
  print(p3, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
  print(p4, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))
  if(!is.null(filename)){
    dev.off()
  }
  
}

#############
#Load GSEA results
#############
#Fezf2_vs_GFP_rank_CSMN<-read.table('CSMN gene enrichment/CSMN_enrichment_Test_decending_fpkm1.GseaPreranked.1395871935795/P3P6 <=-3.xls',header=T,sep="\t")
#Fezf2_vs_GFP_rank_CPN<-read.table('CSMN gene enrichment/CSMN_enrichment_Test_decending_fpkm1.GseaPreranked.1395871935795/P3P6 >=3.xls',header=T,sep="\t")

Leg_test_rank<-read.table('my_analysis.GseaPreranked.1428687690090/JACKS_TREATED_MEFS_UP.xls',header=T,sep="\t")

MEFS_down<-read.table("GSEA_OUT/my_analysis.GseaPreranked.1428805834125/JACKS_UNTREATED_MEFS_DOWN.xls",header=T,sep="\t")
MEFS_up<-read.table("GSEA_OUT/my_analysis.GseaPreranked.1428805834125/JACKS_UNTREATED_MEFS_UP.xls",header=T,sep="\t")


#makeGSEAplot(Fezf2_vs_GFP_rank_CSMN,filename="Fezf2_vs_GFP_rank_CSMN.pdf",title="Fezf2 vs GFP\nTest-stat rank\nP3P6 <=-3 (CSMN)",zeroCross=c(6152,6487))
#makeGSEAplot(Fezf2_vs_GFP_rank_CPN,filename="Fezf2_vs_GFP_rank_CPN.pdf",title="Fezf2 vs GFP\nTest-stat rank\nP3P6 >=3 (CPN)",zeroCross=c(6152,6487))
makeGSEAplot(Leg_test_rank,filename="test_leg_image.pdf",title="Test Leg GSEA", zeroCross=c(8606,8608)) #WHAT IS ZERO CROSS? 
makeGSEAplot(MEFS_down,filename="MEFS_down_GSEAimage.pdf",title="MEFs Jacks Down", zeroCross=c(6735)) #WHAT IS ZERO CROSS? 
makeGSEAplot(MEFS_up,filename="MEFS_up_GSEAimage.pdf",title="MEFs Jacks Up", zeroCross=c(6735)) #WHAT IS ZERO CROSS? 



#Fezf2 bound
#CSMN_enrichment_Test_descending_and_Fezf2_bound.GseaPreranked.1394740380970
Fezf2_vs_GFP_rank_CSMN_bound<-read.table('CSMN gene enrichment/CSMN_enrichment_Test_decending_fpkm1_bound.GseaPreranked.1395871981577/P3P6LT.3.xls',header=T,sep="\t")
Fezf2_vs_GFP_rank_CPN_bound<-read.table('CSMN gene enrichment/CSMN_enrichment_Test_decending_fpkm1_bound.GseaPreranked.1395871981577/P3P6GT3.xls',header=T,sep="\t")


makeGSEAplot(Fezf2_vs_GFP_rank_CSMN_bound,filename="Fezf2_vs_GFP_rank_CSMN_bound.pdf",title="Fezf2 vs GFP Fezf2-bound\nTest-stat rank\nP3P6 <=-3 (CSMN)",zeroCross=c(6152,6487))

makeGSEAplot(Fezf2_vs_GFP_rank_CPN_bound,filename="Fezf2_vs_GFP_rank_CPN_bound.pdf",title="Fezf2 vs GFP Fezf2-bound\nTest-stat rank\nP3P6 >=3 (CPN)",zeroCross=c(6152,6487))



blah<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/analysis/GSEA_OUT/my_analysis.GseaPreranked.1430163594521/JACKS_UNTREATED_MEFS_DOWN.xls",header=T,sep="\t",quote="")
#blah<-read.table("/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/analysis/GSEA_OUT/my_analysis.GseaPreranked.1430163594521/JACKS_UNTREATED_MEFS_DOWN.xls",header=T,sep="\t")


# makeGSEAplot(RAP1_rnk_vs_hRNPU_sig_dn,filename="RAP1_rnk_vs_hRNPU_sig_dn.pdf",title="RAP1_rnk_vs_hRNPU_sig_dn")

# makeGSEAplot(RAP1_rnk_vs_hRNPU_sig_up,filename="RAP1_rnk_vs_hRNPU_sig_up.pdf",title="RAP1_rnk_vs_hRNPU_sig_up")

####
#Testing
####
#makeGSEAplot(hRNPU_rnk_vs_RAP1_sig_dn,title="hRNPU_rnk_vs_RAP1_sig_dn")

#######
# Reporting
########
write.table(Fezf2_vs_GFP_rank_CSMN,"CSMN_geneset_enrichment.txt",quote=F,sep="\t",row.names=F)
write.table(Fezf2_vs_GFP_rank_CPN,"CPN_geneset_enrichment.txt",quote=F,sep="\t",row.names=F)