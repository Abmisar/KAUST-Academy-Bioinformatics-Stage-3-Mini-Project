# **Report: Differential Gene Expression and Functional Analysis of TDP-43 Knockout on Chromosome 21**
**Date:** February 7th, 2026

**Group Members (chr21):**
* Raiyan Tarek Mahmoud Subedar
* Abdullah Waleed Abdullah Misar
* Abdulrahman Mohammed Amin Alahmed
* Turky AbdulHakim Mohammed AlSulaiman

### 1. Introduction and Data Quality Control
The analysis was performed in a Linux environment using raw RNA-seq data sourced from Zenodo (GSE136366). The dataset consists of paired-end FASTQ files representing three biological replicates per condition:

• WT Samples: WT_1, WT_2, WT_3

• KO Samples: KO_1, KO_2, KO_3

The analysis of RNA-seq data derived from Chromosome 21 is to assess the impact of TDP-43 knockout (KO). The raw data was processed using a Salmon-tximport-DESeq2 pipeline.

To optimize computational efficiency, the analysis utilized chromosome 21-specific reference files derived from the full human GRCh38 (Ensembl release 110) genome.
Reference Statistics (Chromosome 21)
| Metric         | Count      |
| -------------- | ---------- |
| DNA base pairs | 46,709,983 |
| Genes          | 898        |
| Transcripts    | 3,281      |
| Transcript nt  | 3,726,362  |

**Quality Control on Trimmed Data**

Quality control and trimming were performed using **fastp** and **FastQC** to ensure high data integrity prior to alignment. 
The trimming process specifically targeted low-quality bases (Q-score < 20) and adapters, while discarding any reads shorter than 36 base pairs.

This step resulted in a moderate reduction in total read counts (e.g., sample KO_1 decreased from 708,774 to 674,162 reads) and shifted the read length distribution from a fixed 76 bp to a variable range of 36–76 bp. 
Final verification using **[MultiQC](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/qc_reports/multiqc_all.html)** confirmed that the process successfully removed low-quality content while preserving the majority of the original sequencing depth.

Before analyzing gene expression changes, quality control was performed to ensure the reliability of the dataset. The library sizes were comparable across conditions, with WT samples averaging approximately 1.8 million reads and KO samples averaging 1.5 million reads.

Principal Component Analysis (PCA) was conducted to visualize the variance between samples. The results confirm a distinct separation between the two groups, with PC1 accounting for 50.9% of the variance, indicating a strong biological effect of the knockout.

**![PCA KO vs WT](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/figures/pca_ko_vs_wt.png)**
*Figure 1: Principal Component Analysis (PCA) showing clear clustering of KO samples (red) versus WT samples (green).*

Additionally, sample correlation analysis confirms that biological replicates within each condition are highly correlated.

**![Sample Correlation Heatmap](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/figures/sample_correlation_heatmap.png)**
*Figure 2: Sample correlation heatmap demonstrating high consistency between replicates within the same condition.*

### 2. Differential Expression Analysis
Differential expression analysis identified a specific subset of genes affected by the loss of TDP-43. Out of 132 genes tested after filtering for low counts, **7 genes** met the significance criteria of an adjusted p-value (padj) < 0.05 and a |log2FoldChange| > 1.

Because this analysis is restricted to Chromosome 21, the input data for DESeq2 consisted of reads specifically mapped to this chromosome. Mapping rates were consistent (47–61%) across all samples (Chromosome 21 is both the smallest human autosome and chromosome, containing approximately 200–300 protein-coding genes). 

The effective library sizes (total mapped counts) averaged approximately 0.4 million per sample, ensuring comparable depth for statistical analysis.
**![Library Size](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/figures/library_sizes.png)**
*Figure 3: Effective library sizes (total mapped counts) per sample. The consistency across KO and WT conditions ensures no bias in sequencing depth prior to normalization.*

The overall distribution of gene expression changes is visualized below. The volcano plot highlights the significant genes in the upper left (downregulated) and upper right (upregulated) quadrants.

**![Volcano Plot](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/figures/volcano_plot.png)**
*Figure 4: Volcano plot displaying differential expression. Red dots indicate upregulated genes and blue dots indicate downregulated genes meeting significance thresholds.*

#### 2.1 Affected Genes
The response to TDP-43 loss on Chromosome 21 is characterized primarily by upregulation, consistent with the loss of a repressive factor.

**Upregulated Genes (5 identified):**
These genes showed increased abundance in the knockout samples:
*   **ENSG00000183486:** +2.42 log2 fold change (strongest magnitude).
*   **ENSG00000142156:** +1.76 log2 fold change.
*   **ENSG00000185437:** +1.32 log2 fold change.
*   **ENSG00000160183:** +1.26 log2 fold change (most significant, padj 2.28e-33).
*   **ENSG00000154654:** +1.17 log2 fold change.

**Downregulated Genes (2 identified):**
These genes showed decreased abundance:
*   **ENSG00000154736:** -3.28 log2 fold change.
*   **ENSG00000160233:** -1.36 log2 fold change.

The consistency of these changes across individual samples is shown in the heatmap below.

**![Top Genes Heatmap](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/figures/top_genes_heatmap.png)**
*Figure 5: Heatmap of the top 7 differentially expressed genes, showing consistent expression profiles across all three replicates per condition.*

### 3. Disrupted Biological Processes
Enrichment analysis using g:Profiler was performed to determine the biological implications of these gene expression changes.

#### 3.1 Cellular Component (GO)
The most significant disruptions occurred in genes associated with the extracellular matrix and structural integrity. Specifically, the analysis highlighted **"collagen type VI trimer,"** **"collagen beaded filament,"** and the **"basement membrane/interstitial matrix interface"**.

**![GO All Significant Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/enrichment/go_all_genes_bar.png)**
*Figure 6: Gene Ontology (Cellular Component) enrichment analysis showing significant associations with collagen and basement membrane structures.*

#### 3.2 KEGG Pathways
Pathway analysis identified associations with viral response mechanisms. The significant pathways included **"Human papillomavirus infection"** and **"Virion - Ebolavirus and Lyssavirus"**.

**![KEGG Pathways All DE Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/blob/main/genomics/results/enrichment/kegg_all_bar.png)**
*Figure 7: KEGG Pathway enrichment showing significant associations with viral infection pathways.*

### 4. Chromosome 21 Response to TDP-43 loss
The response of Chromosome 21 to TDP-43 knockout is characterized as highly specific rather than globally disruptive.
Only 7 genes showed strong fold changes (|LFC| > 1) out of the 132 tested, and only 2 genes exceeded a 4-fold change (log2FoldChange > 2). 
This suggests that while TDP-43 is essential, its loss does not cause a global deregulation of the entire chromosome.

#### 5. Links to ALS/FTD Pathology
Although this analysis focused on Chromosome 21, the results show three patterns often seen in ALS and FTD patients:
1.  **Loss of Control:** . In this experiment, most affected genes became overactive (upregulated). This mirrors ALS pathology, where the loss of TDP-43 allows specific genes to run out of control.
2.  **Structural Weakness:** The analysis found that genes responsible for building the cell's physical framework (collagen and basement membrane) were disrupted.
3.  False Viral Alarm: The cells activated pathways usually used to fight viruses (e.g., HPV, Ebola), even though no virus was present. This "false alarm" is a common stress response in ALS/FTD, where internal genetic errors are mistaken by the cell for a viral attack.
