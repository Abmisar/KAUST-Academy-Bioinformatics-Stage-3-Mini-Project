# QC Visualization Run in Jupyter Notebook

Each code block below was designed to run as a separate Jupyter notebook cell for QC visualization of RNA-seq data.

---

## Library Size Bar Chart

Shows total counts per sample.

![Library Sizes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/library_sizes.png)

---

## Count Distribution - Boxplot

Distribution of gene counts per sample (log10 transformed).

![Count Distribution Boxplot](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/count_boxplot_distribution.png)

---

## Count Distribution - Violin Plot

Another view of gene count distributions (log10 transformed).

![Count Distribution Violin](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/count_violin_distribution.png)

---

## PCA Plot: KO vs WT

Principal Component Analysis showing clustering of KO (red) and WT (green) samples.

![PCA KO vs WT](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/pca_ko_vs_wt.png)

**Interpretation:**

- Samples that cluster together have similar expression profiles.
- KO samples (red) should cluster separately from WT samples (green).
- PC1 captures the most variance – often the biological condition of interest.
- Replicates should cluster together within each condition.

---

## MA Plot

Shows relationship between expression level and fold change. Red points are significant.

![MA Plot](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/MA_plot.png)

---

## Volcano Plot

Combines fold change and statistical significance. Top corners contain the most interesting genes.

![Volcano Plot](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/volcano_plot.png)

---

## Sample Correlation Heatmap

Replicates should correlate highly with each other.

![Sample Correlation Heatmap](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/sample_correlation_heatmap.png)

---

## Top Genes Heatmap

Shows expression patterns of the most significant genes across samples.

![Top Genes Heatmap](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/figures/top_genes_heatmap.png)

---

## Differential Expression Summary

Summary of differential expression analysis (using DESeq2):

- **Total genes tested:** 132

**Genes at different significance thresholds:**

- padj < 0.1: 64  
- padj < 0.05: 52  
- padj < 0.01: 41  
- padj < 0.05 & |LFC| > 1: 7  
- padj < 0.05 & |LFC| > 2: 2  

**Up- vs Down-regulated genes (padj < 0.05 & |LFC| > 1):**

- Upregulated in KO: 5  
- Downregulated in KO: 2
