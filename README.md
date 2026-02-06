# KAUST-Academy-Bioinformatics-Stage-3-Mini-Project: Chromosome-specific TDP-43 Knockout Analysis (chr21)

## Project Goal

This group project analyzes the effect of **TDP-43 knockout** on gene expression in an assigned chromosome. Using the same experimental RNA-seq dataset (**GSE136366**) provided in the labs, we apply a complete RNA-seq analysis pipeline to identify **chromosome-specific transcriptional effects** of TDP-43 loss.

This repository focuses on **chromosome 21 (chr21)**.

---

## Project Overview

### Background

TDP-43 is a ubiquitously expressed RNA-binding protein that regulates thousands of RNA targets across the genome. Although the lab exercises focused on **chromosome 11**, the regulatory effects of TDP-43 extend across all chromosomes.

This project investigates whether **chromosome 21** exhibits distinct or particularly strong responses to TDP-43 knockout.

### Key Questions

* Which **chr21 genes** are affected by TDP-43 knockout?
* What **biological processes and pathways** are disrupted?
* Does chromosome 21 show **unique or pronounced responses** to TDP-43 loss?
* Are any affected genes linked to **ALS/FTD-related pathology**?

---

## Dataset

* **RNA-seq dataset:** GSE136366
* **Chromosome-specific data (chr21):**
  [https://zenodo.org/records/18481303/files/chr21_data.zip](https://zenodo.org/records/18481303/files/chr21_data.zip)

Download and extract the chr21 data into the `raw_data/` directory before running the analysis.

---

## Project Directory Structure

```text
.
├── alignment/          # Genome alignment outputs (e.g., BAM files)
├── counts/             # Gene-level count matrices
├── logs/               # Log files from all pipeline steps
├── qc_reports/
│   ├── fastp/          # fastp trimming reports
│   ├── fastqc_raw/     # FastQC reports for raw FASTQ files
│   └── fastqc_trimmed/ # FastQC reports for trimmed FASTQ files
├── raw_data/           # Original raw FASTQ files
├── references/         # Reference genome, transcriptome, and annotation files
├── results/
│   ├── enrichment/     # Functional enrichment results (GO, KEGG, etc.)
│   ├── figures/        # Plots and visualizations
│   └── tables/         # Final result tables
├── salmon_quant/       # Transcript-level quantification results from Salmon
├── scripts/            # R script
├── subsampled_data/    # Subsampled FASTQ files for testing/debugging
└── trimmed_data/       # Trimmed FASTQ files after quality control
```

---

## Workflow Summary

1. Quality control of raw reads (**FastQC**)
2. Read trimming and filtering (**fastp**)
3. Post-trimming QC (**FastQC + MultiQC**)
4. Genome alignment or transcriptome quantification (**STAR / Salmon**)
5. Gene-level counting
6. Differential expression analysis
7. Functional enrichment analysis
8. Visualization and result reporting

---

## Group Members (chr21)

* Raiyan Tarek Mahmoud Subedar
* Abdullah Waleed Abdullah Misar
* Abdulrahman Mohammed Amin Alahmed
* Turky AbdulHakim Mohammed AlSulaiman

---

## Documentation

Detailed step-by-step documentation of the project workflow is available in the `docs/` folder:

1. [Raw Data Download](docs/1-raw_data-download.md) – Download and organize the RNA-seq FASTQ files  
2. [Reference Genome and Annotation Download](docs/2-reference-data-download.md) – Download chromosome 21 genome, GTF, and transcriptome  
3. [Reference Statistics](docs/3-reference-stats.md) – Number of genes, transcripts, DNA base pairs, and transcript nucleotides  
4. [Raw Sequencing QC with SeqKit](docs/4-seqkit-qc.md) – Summary of raw reads, GC content, Q30%, and observations
5. [Quality Control and Read Trimming](docs/5-qc-and-trimming.md) – FastQC, multiQC, and fastp trimming results
6. [Transcript Quantification with Salmon and tximport](docs/6-salmon-quantification-and-tximport.md) – Salmon quantification and gene-level counts with tximport
7. [Differential Expression Analysis](docs/7-differential-expression.md) – Compare WT and KO samples to detect significantly up- and down-regulated chromosome 21 genes.
8. [Visualization and QC Plots](docs/8-visualization-and-qc-plots.md) – Diagnostic plots for quality control, sample relationships, and differential expression results.
9. [Enrichment Analysis](docs/9-enrichment-analysis.md) – GO and KEGG functional enrichment analysis of significant differentially expressed genes.


