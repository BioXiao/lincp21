

Trp53cor1 KO vs WT (Heart)
======================================




```
## Error in file(file, "r"): cannot open the connection
```



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

![plot of chunk MvA](figure/MvA-1.png) 
   
### MvA plot counts

![plot of chunk MvA_counts](figure/MvA_counts-1.png) 

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





















































