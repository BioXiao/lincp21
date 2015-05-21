#Pretty GSEA

# 

#source("http://bioconductor.org/biocLite.R")
#biocLite("piano")
library(piano)

# loadGSC

# runGSA

# runGSAhyper

# http://www.bioconductor.org/packages/release/bioc/vignettes/ReactomePA/inst/doc/ReactomePA.pdf
library(ReactomePA)

?viewPathway
#viewPathway("REACTOME_TRANSLATION",readable=TRUE,foldChange=Input.df)

require(DOSE)
data(geneList)
de <- names(geneList)[abs(geneList) > 1]
head(de)
require(ReactomePA)
x <- enrichPathway(gene = de, pvalueCutoff = 0.05,
                   readable = T)

head(summary(x))

require(clusterProfiler)

y <- gsePathway(geneList, nPerm = 100, minGSSize = 120,
                pvalueCutoff = 0.05, pAdjustMethod = "BH", verbose = FALSE)
res <- summary(y)
head(res)



library(GSA)
#http://cran.r-project.org/web/packages/GSA/GSA.pdf