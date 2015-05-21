

Trp53cor1 KO vs WT (brain)
======================================







This file shows the wt-v-ko comparison for Trp53cor1. 

Cuff overview:


```
## CuffSet instance with:
## 	 2 samples
## 	 26754 genes
## 	 77524 isoforms
## 	 0 TSS
## 	 23066 CDS
## 	 0 promoters
## 	 0 splicing
## 	 19954 relCDS
```

# QC

## Dispersion

Dispersion plot for genes in cuff:
(Overdispersion can lead to innacurate quants)

![plot of chunk dispersion](figure/dispersion-1.png) 

## Cross-replicate variability (fpkmSCVplot)
Differences in CV 2 can result in lower numbers of differentially expressed genes due to a higher degree of variability between replicate fpkm estimates.

Genes:

![plot of chunk CV_genes](figure/CV_genes-1.png) 

Isoforms: 

![plot of chunk cv_iso](figure/cv_iso-1.png) 

## MvA plot


```
## Error in dat$y + pseudocount: non-numeric argument to binary operator
```
   
### MvA plot counts


```
## Error in dat$y + pseudocount: non-numeric argument to binary operator
```

## Scatterplot matrix

![plot of chunk scatterplot](figure/scatterplot-1.png) 

## Distributions

### Boxplots

Boxplot (genes)

![plot of chunk boxplot_genes](figure/boxplot_genes-1.png) 

Boxplot (genes, replicates)

![plot of chunk boxplot_genes_replicates](figure/boxplot_genes_replicates-1.png) 

Boxplot (isoforms)

![plot of chunk boxplot_isoforms](figure/boxplot_isoforms-1.png) 

Boxplot (isoforms, replicates)

![plot of chunk boxplot_isoforms_replicates](figure/boxplot_isoforms_replicates-1.png) 

### Density

Density (genes)

![plot of chunk density](figure/density-1.png) 

Density (genes, replicates)

![plot of chunk density_w_replicates](figure/density_w_replicates-1.png) 


## Clustering

### Replicate Clusters

![plot of chunk replicate_clusters](figure/replicate_clusters-1.png) 

```
## NULL
```

### PCA (genes)

![plot of chunk PCA](figure/PCA-1.png) 

### MDS (genes)

![plot of chunk MDS](figure/MDS-1.png) 





# KO assessment

## Endogenous lncRNA expression

![plot of chunk lincp21](figure/lincp21-1.png) 

![plot of chunk lacZ](figure/lacZ-1.png) 

## Digital Genotyping (LacZ vs Endogenous lncRNA and Sex)

Eif2s3y is a y-expressed gene, Xist is an x-expressed gene 
Expression plot (endogenous linc, lacZ, Y-expressed gene):

![plot of chunk Digital_Genotyping](figure/Digital_Genotyping-1.png) 

Expression heatmap:

![plot of chunk digital_geno_heatmap](figure/digital_geno_heatmap-1.png) 

### Track visualization 


```
## Error in validObject(.Object): invalid class "ReferenceDataTrack" object: The referenced file '/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/bam/abundances.cxb/accepted_hits.bam' does not exist
```

# Differential Analysis

## Differential Genes 


```
## Error in sqliteExecStatement(con, statement, bind.data): RS-DBI driver: (error in statement: near ")": syntax error)
```

```
## Error in annotation(sigGenes): error in evaluating the argument 'object' in selecting a method for function 'annotation': Error: object 'sigGenes' not found
```

```
## Error in diffData(sigGenes): error in evaluating the argument 'object' in selecting a method for function 'diffData': Error: object 'sigGenes' not found
```

There are 0 significantly differentially expressed genes. They are:

[1] "No sig genes!"

Expression heatmap of sigGenes


```
## Error in csHeatmap(sigGenes, cluster = "both", replicates = T): error in evaluating the argument 'object' in selecting a method for function 'csHeatmap': Error: object 'sigGenes' not found
```

Foldchange heatmap of sigGenes 


```
## Error in csFoldChangeHeatmap(sigGenes, "WT", replicates = TRUE, replicate_num = 0, : error in evaluating the argument 'object' in selecting a method for function 'csFoldChangeHeatmap': Error: object 'sigGenes' not found
```



Now, look at genes that are detectably expressed (FPKM>0.5, yes I know it should be 1), and log2foldchange>2 in any direction: 26 genes

![plot of chunk expressed_and_changing](figure/expressed_and_changing-1.png) 


```
## Error in sqliteExecStatement(con, statement, bind.data): RS-DBI driver: (error in statement: near ")": syntax error)
```

Now, those that are expressed, changing and called sig: 0 genes 

![plot of chunk expressed_and_changing_andSIG](figure/expressed_and_changing_andSIG-1.png) 

### Expression-level/significance relationship

Scatter plot of significant genes only:


```
## Error in csScatter(sigGenes, "WT", strain_sample, smooth = T): error in evaluating the argument 'object' in selecting a method for function 'csScatter': Error: object 'sigGenes' not found
```

Volcano Plot


```
## Error in .local(object, x, y, features, ...): One or more values of 'x' or 'y' are not valid sample names!
```

Volcano plot with significant genes only:


```
## Error in csVolcano(sigGenes, "WT", strain_sample, showSignificant = TRUE, : error in evaluating the argument 'object' in selecting a method for function 'csVolcano': Error: object 'sigGenes' not found
```

### Differential Isoforms between conditions

Per isoform difference between conditions:

![plot of chunk diff_iso](figure/diff_iso-1.png) 

These isoforms are:

[1] "no sig isoforms"

DE isoform heatmap


```
## [1] "no sig isoforms"
```

Isoform foldchange heatmap by isoform:


```
## [1] "no sig isoforms"
```

# Gene/Pathway Analysis

## GSEA

Enrichment and zscores are calculated based on expression in KO vs WT (fpkmKO/fpkmWT), so genes that are down regulated in KO are shown in blue, while upregulation is shown in red. 

KO/WT
Blue = down in KO
Red = Up in KO





Biocarta enrichment: 


```
## Error in heatmap.2(x_ordered, trace = "none", col = InputCols, breaks = enrichmentBreaks, : `x' must have at least 2 rows and 2 columns
```

Biocarta zscore: 


```
## Error in x[, 1]: incorrect number of dimensions
```

```
## Error in eval(expr, envir, enclos): object 'x_ordered' not found
```

```
## Error in as.matrix(x_ordered): error in evaluating the argument 'x' in selecting a method for function 'as.matrix': Error: object 'x_ordered' not found
```

```
## Error in eval(expr, envir, enclos): object 'x_ordered' not found
```

Reactome enrichment:


```
## Error in x_ordered[1:50, ]: subscript out of bounds
```

![plot of chunk print_GSEA_reactome](figure/print_GSEA_reactome-1.png) 

Reactome zscore: 


```
## Error in x_ordered[1:50, ]: subscript out of bounds
```

![plot of chunk gsea_zscore_reactome](figure/gsea_zscore_reactome-1.png) 

Kegg enrichment: 

![plot of chunk gsea_enrichment_kegg](figure/gsea_enrichment_kegg-1.png) 

Kegg zscore: 

![plot of chunk gsea_zscore_kegg](figure/gsea_zscore_kegg-1.png) 


p53 enrichment: 

![plot of chunk gsea_enrichment_p53](figure/gsea_enrichment_p53-1.png) 

p53 zscore: 

![plot of chunk gsea_zscore_p53](figure/gsea_zscore_p53-1.png) 

Oncogene enrichment: 

![plot of chunk gsea_enrich_onco](figure/gsea_enrich_onco-1.png) 

Oncogene zscore:

![plot of chunk gsea_zscore_onco](figure/gsea_zscore_onco-1.png) 


Jacks enrichment

```
## [1] "Not enough significant categories to print a heatmap!"
```


Jacks zscore


```
## [1] "Not enough significant categories to print a heatmap!"
```


Consistantly changing genes enrichment:

```
## Error in (function (side, at = NULL, labels = TRUE, tick = TRUE, line = NA, : no locations are finite
```

![plot of chunk consistant_enrich](figure/consistant_enrich-1.png) 


![plot of chunk consistant_zscore](figure/consistant_zscore-1.png) 


All enrichment 



There are 462 categories enriched (p<0.0001). They are:

![plot of chunk gsea_enrich_fig](figure/gsea_enrich_fig-1.png) 

ALL zscore:

![plot of chunk gsea_zscore_fig](figure/gsea_zscore_fig-1.png) 

## GO enrichment 
Cluster profiler used to call enichments of significantly differentially regulated genes that map to Entrez IDs. 


```
## Error in sqliteExecStatement(con, statement, bind.data): RS-DBI driver: (error in statement: near ")": syntax error)
```

```
## Error in annotation(sigGenes): error in evaluating the argument 'object' in selecting a method for function 'annotation': Error: object 'sigGenes' not found
```

```
## Error in eval(expr, envir, enclos): object 'geneAnnot' not found
```

```
## Error in diffData(sigGenes): error in evaluating the argument 'object' in selecting a method for function 'diffData': Error: object 'sigGenes' not found
```

```
## Error in eval(expr, envir, enclos): object 'sigDiff' not found
```


```
## Error in getBM(attributes = c("entrezgene"), filters = "mgi_symbol", values = geneNames, : object 'geneNames' not found
```

```
## Error in strsplit(as.character(sigEntrez), ", "): object 'sigEntrez' not found
```

```
## Error in unlist(sigEZ): error in evaluating the argument 'x' in selecting a method for function 'unlist': Error: object 'sigEZ' not found
```

```
## Error in enrich.internal(gene, organism = organism, pvalueCutoff = pvalueCutoff, : object 'sigEZ' not found
```

```
## Error in enrich.internal(gene, organism = organism, pvalueCutoff = pvalueCutoff, : object 'sigEZ' not found
```

```
## Error in enrich.internal(gene, organism = organism, pvalueCutoff = pvalueCutoff, : object 'sigEZ' not found
```

```
## Error in enrich.internal(gene, organism = organism, pvalueCutoff = pvalueCutoff, : object 'sigEZ' not found
```

```
## Error in enrich.internal(gene, organism = organism, pvalueCutoff = pvalueCutoff, : object 'sigEZ' not found
```


```
## Error in plot(goBP, showCategory = 20): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'goBP' not found
```

```
## Error in plot(goMF, showCategory = 20): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'goMF' not found
```

```
## Error in plot(goCC, showCategory = 20): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'goCC' not found
```

```
## Error in plot(kegg, showCategory = 20): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'kegg' not found
```

```
## Error in plot(pathway, showCategory = 20): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'pathway' not found
```

# Cis vs Trans (locally)

log2 Foldchange and test statistic are calculated with the ratio of fpkm(KO)/fpkm(WT), thus the test_stat is positive if a gene is higher in the KO and negative if a gene has lower expression in the KO





The pvalue for genes significantly regulated in a region this size  is: 1 

![plot of chunk cisreg_image](figure/cisreg_image-1.png) 

# Notes

## Samples used are:
<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Mon Apr 13 20:49:25 2015 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> 11 </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 14 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 15 </TD> <TD> abundances.cxb </TD> </TR>
  <TR> <TD align="right"> 16 </TD> <TD> abundances.cxb </TD> </TR>
   </TABLE>

## Replicates
<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Mon Apr 13 20:49:26 2015 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> file </TH> <TH> sample_name </TH> <TH> replicate </TH> <TH> rep_name </TH> <TH> total_mass </TH> <TH> norm_mass </TH> <TH> internal_scale </TH> <TH> external_scale </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR753/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   0 </TD> <TD> WT_0 </TD> <TD align="right"> 39331900.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.28 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR750/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   1 </TD> <TD> WT_1 </TD> <TD align="right"> 36031100.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.11 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR771/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   2 </TD> <TD> WT_2 </TD> <TD align="right"> 38857100.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.24 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR755/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   3 </TD> <TD> WT_3 </TD> <TD align="right"> 41811300.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.30 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR811/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   4 </TD> <TD> WT_4 </TD> <TD align="right"> 38172800.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.21 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR768/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   5 </TD> <TD> WT_5 </TD> <TD align="right"> 28375200.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.90 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR761/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   6 </TD> <TD> WT_6 </TD> <TD align="right"> 31706200.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.98 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR815/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   7 </TD> <TD> WT_7 </TD> <TD align="right"> 29733100.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.93 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR789/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   8 </TD> <TD> WT_8 </TD> <TD align="right"> 27681500.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.87 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR748/abundances.cxb </TD> <TD> WT </TD> <TD align="right">   9 </TD> <TD> WT_9 </TD> <TD align="right"> 32367000.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.97 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR716/abundances.cxb </TD> <TD> WT </TD> <TD align="right">  10 </TD> <TD> WT_10 </TD> <TD align="right"> 26144700.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.82 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR717/abundances.cxb </TD> <TD> WT </TD> <TD align="right">  11 </TD> <TD> WT_11 </TD> <TD align="right"> 25565400.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.81 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR719/abundances.cxb </TD> <TD> WT </TD> <TD align="right">  12 </TD> <TD> WT_12 </TD> <TD align="right"> 22697800.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.69 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 14 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR756/abundances.cxb </TD> <TD> WT </TD> <TD align="right">  13 </TD> <TD> WT_13 </TD> <TD align="right"> 38948900.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.23 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 15 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb </TD> <TD> Trp53cor </TD> <TD align="right">   0 </TD> <TD> Trp53cor_0 </TD> <TD align="right"> 31241000.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 0.95 </TD> <TD align="right"> 1.00 </TD> </TR>
  <TR> <TD align="right"> 16 </TD> <TD> /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb </TD> <TD> Trp53cor </TD> <TD align="right">   1 </TD> <TD> Trp53cor_1 </TD> <TD align="right"> 31403400.00 </TD> <TD align="right"> 31980100.00 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 1.00 </TD> </TR>
   </TABLE>

## Session Info

```
## R version 3.0.2 (2013-09-25)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] grid      parallel  methods   stats     graphics  grDevices utils    
## [8] datasets  base     
## 
## other attached packages:
##  [1] plyr_1.8.1                         
##  [2] stringr_0.6.2                      
##  [3] seqbias_1.10.0                     
##  [4] BSgenome.Mmusculus.UCSC.mm10_1.3.19
##  [5] BSgenome_1.30.0                    
##  [6] Biostrings_2.30.1                  
##  [7] org.Mm.eg.db_2.10.1                
##  [8] clusterProfiler_1.13.1             
##  [9] DOSE_2.0.0                         
## [10] ReactomePA_1.6.1                   
## [11] AnnotationDbi_1.24.0               
## [12] Biobase_2.22.0                     
## [13] mgcv_1.8-2                         
## [14] nlme_3.1-117                       
## [15] RMySQL_0.9-3                       
## [16] RColorBrewer_1.0-5                 
## [17] gridExtra_0.9.1                    
## [18] gtable_0.1.2                       
## [19] marray_1.40.0                      
## [20] gplots_2.14.2                      
## [21] GSA_1.03                           
## [22] limma_3.18.13                      
## [23] xtable_1.7-3                       
## [24] cummeRbund_2.7.2                   
## [25] Gviz_1.6.0                         
## [26] rtracklayer_1.22.7                 
## [27] GenomicRanges_1.14.4               
## [28] XVector_0.2.0                      
## [29] IRanges_1.20.7                     
## [30] fastcluster_1.1.13                 
## [31] reshape2_1.4                       
## [32] ggplot2_1.0.0                      
## [33] RSQLite_0.11.4                     
## [34] DBI_0.3.1                          
## [35] BiocGenerics_0.8.0                 
## [36] knitr_1.7                          
## 
## loaded via a namespace (and not attached):
##  [1] biomaRt_2.18.0         biovizBase_1.10.8      bitops_1.0-6          
##  [4] caTools_1.17.1         cluster_1.15.2         colorspace_1.2-4      
##  [7] dichromat_2.0-0        digest_0.6.4           DO.db_2.7             
## [10] evaluate_0.5.5         formatR_1.0            Formula_1.1-2         
## [13] gdata_2.13.3           GenomicFeatures_1.14.5 GO.db_2.10.1          
## [16] GOSemSim_1.20.3        graph_1.40.1           graphite_1.8.1        
## [19] gtools_3.4.1           Hmisc_3.14-4           igraph_0.7.1          
## [22] KEGG.db_2.10.1         KernSmooth_2.23-12     labeling_0.2          
## [25] lattice_0.20-29        latticeExtra_0.6-26    MASS_7.3-33           
## [28] Matrix_1.1-4           munsell_0.4.2          org.Hs.eg.db_2.10.1   
## [31] proto_0.3-10           qvalue_1.36.0          Rcpp_0.11.3           
## [34] RCurl_1.95-4.3         reactome.db_1.46.1     Rsamtools_1.14.3      
## [37] scales_0.2.4           splines_3.0.2          stats4_3.0.2          
## [40] survival_2.37-7        tcltk_3.0.2            tools_3.0.2           
## [43] XML_3.98-1.1           zlibbioc_1.8.0
```

## Run Info

```
##           param
## 1      cmd_line
## 2       version
## 3  SVN_revision
## 4 boost_version
## 5        genome
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  value
## 1 cuffdiff -p 10 -L WT,Trp53cor -o /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/diffs/Trp53cor_vs_WT_Embryonic /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/annotation/mm10_gencode_vM2_with_lncRNAs_and_LacZ.gtf /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR753/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR750/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR771/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR755/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR811/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR768/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR761/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR815/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR789/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR748/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR716/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR717/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR719/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR756/abundances.cxb /n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR749/abundances.cxb,/n/rinn_data1/seq/lgoff/Projects/BrainMap/data/quants/JR814/abundances.cxb 
## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                2.2.1
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 4237
## 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               104700
## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 mm10
```

