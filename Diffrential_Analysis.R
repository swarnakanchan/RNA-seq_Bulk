
# R code for bulk RNA-seq (Transcriptomics) differential gene expression data analysis


# Read read counts per gene, counts table

countdata <- read.csv("counts_all.csv", header=TRUE, row.names=1)

countdata <- as.matrix(countdata)

head (countdata)

# Assign condition 5 control, 5 treatments

(condition = factor(c("ctl","ctl","ctl","ctl","ctl","trt","trt","trt","trt","trt")))


(coldata <- data.frame(row.names=colnames(countdata), condition))


library(DESeq2)

dds <- DESeqDataSetFromMatrix(countData = countdata,colData = coldata, design=~condition)

dds

dds <- dds [ rowSums (counts(dds)) > 0, ]

dds

nrow(dds)

#Run the pipeline

dds <- DESeq(dds)

resultsNames(dds)

# Plot dispersions
png("qc-dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

library(ggplot2)


# Regularized log (vst) transformation for PCA, clustering/heatmaps, etc

vstData <- vst(dds, blind=F)

head(assay(vstData))
hist(assay(vstData))

write.csv(assay(vstData), "vstData.csv")



# Simple distances for heatmaps

sampleDists <- as.matrix(dist(t(assay(vstData))))

library(RColorBrewer)
library (pheatmap)

colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)

#Heatmap (Simple distances)

pheatmap(sampleDists,col=colors)



# Principal components analysis  with built-in DESeq2 function

plotPCA(vstData, intgroup= c("condition"))

# I like mine PCA plot better:
library(RColorBrewer)
(mycols <- brewer.pal(8, "Dark2")[1:length(unique(condition))])
vstData_pca <- function (vstData, intgroup = "condition", ntop = 500, colors=NULL, legendpos="bottomleft", main="PCA Biplot", textcx=1, ...) {
  require(genefilter)
  require(calibrate)
  require(RColorBrewer)
  rv = rowVars(assay(vstData))
  select = order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  pca = prcomp(t(assay(vstData)[select, ]))
  fac = factor(apply(as.data.frame(colData(vstData)[, intgroup, drop = FALSE]), 1, paste, collapse = " : "))
  if (is.null(colors)) {
    if (nlevels(fac) >= 3) {
      colors = brewer.pal(nlevels(fac), "Paired")
    }   else {
      colors = c("black", "red")
    }
  }
  pc1var <- round(summary(pca)$importance[2,1]*100, digits=1)
  pc2var <- round(summary(pca)$importance[2,2]*100, digits=1)
  pc1lab <- paste0("PC1 (",as.character(pc1var),"%)")
  pc2lab <- paste0("PC2 (",as.character(pc2var),"%)")
  plot(PC2~PC1, data=as.data.frame(pca$x), bg=colors[fac], pch=21, xlab=pc1lab, ylab=pc2lab, main=main, ...)
  with(as.data.frame(pca$x), textxy(PC1, PC2, labs=rownames(as.data.frame(pca$x)), cex=textcx))
  legend(legendpos, legend=levels(fac), col=colors, pch=20)
  #     rldyplot(PC2 ~ PC1, groups = fac, data = as.data.frame(pca$vstData),
  #            pch = 16, cerld = 2, aspect = "iso", col = colours, main = draw.key(key = list(rect = list(col = colours),
  #                                                                                         terldt = list(levels(fac)), rep = FALSE)))
}
png("qc-pca.png", 1000, 1000, pointsize=20)
vstData_pca(vstData, colors=mycols, intgroup="condition", xlim=c(-20, 20))
dev.off()


# Get differential expression results
res <- results(dds)
summary(res)

#Singnificant genes (padj < 0.1)
table(res$padj<0.1)

## Order by adjusted p-value
res <- res[order(res$padj), ]

# Writing the results with-out adding columns for Normalized Counts
write.csv(res, file="diffexpr-results_ConVsTrt_without_NormalizedCounts.csv")


## Merge with normalized count data
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
head(resdata)

## Write results with columns for Normalized Counts
write.csv(resdata, file="diffexpr-results_ConVsTrt_NormalizedCounts.csv")

## Examine plot of p-values
hist(res$pvalue, breaks=50, col="grey")
hist(res$padj, breaks=50, col="grey")


library(calibrate)


# MA Plot Generation
# I like mine better (MA plots)
maplot <- function (res, thresh=0.05, labelsig=TRUE, textcx=1, ...) {
  with(res, plot(baseMean, log2FoldChange, pch=20, cex=.5, log="x", ...))
  with(subset(res, padj<thresh), points(baseMean, log2FoldChange, col="blue", pch=20, cex=1.5))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<thresh), textxy(baseMean, log2FoldChange, labs=Gene, cex=textcx, col=2))
  }
}
png("diffexpr-maplot.png", 1500, 1000, pointsize=20)
maplot(resdata, main="MA Plot")
dev.off()



# conversion of log2FoldChange to normal/absolute expression using R

library(gtools)
conversion <- read.csv(file = 'SignificantGenes.csv')
head(conversion)
conversion$FC1 <- 2^conversion$log2FoldChange
write.csv(conversion$FC1, file = 'conversion_FC2.csv')


# Merging gene symbol into diffrential analysis results

library(dplyr)
library(readr)

#Read main table
main <- read.csv("mymaintable.csv")
head (main)

#Read lookup table

mylookup3 <-read.csv("diffexpr-results.csv")

head (mylookup6)

#Merge table  using left_join().  left_join() means include all rows on the left, or first, data set, but only rows that match from the second one. 

joined_table6 <- left_join(mydf6, mylookup6)


# Write final table
write.csv(joined_table6, file="mymerged6.csv")







