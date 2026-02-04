# Raw Data Download and Organization

This document describes the terminal commands used to download, extract, and organize the raw RNA-seq data for the chromosome 21 TDP-43 knockout analysis. All steps were performed on a Linux environment.

---

## 1. Navigate to the project directory

```bash
cd genomics
````

Moves into the main project directory where all analysis files are stored.

---

## 2. Download the RNA-seq dataset

```bash
wget https://zenodo.org/records/18481303/files/chr21_data.zip
```

Downloads the chromosome 21 RNA-seq dataset from Zenodo.
The archive (~586 MB) contains paired-end FASTQ files for wild-type (WT) and TDP-43 knockout (KO) samples.

---

## 3. Extract the archive and rename the directory

```bash
unzip chr21_data.zip && mv chr21_data raw_data
```

* Extracts the compressed archive
* Renames the extracted directory to `raw_data`, following common bioinformatics conventions

---

## 4. Move FASTQ files to the main `raw_data` directory

```bash
mv raw_data/chr21_data/raw_data/* raw_data/
```

Moves all raw FASTQ files into the top-level `raw_data/` directory to simplify downstream processing.

---

## 5. Verify FASTQ files

```bash
ls raw_data/
```

The directory now contains 12 paired-end FASTQ files representing 3 biological replicates per condition:

* **KO samples:** KO_1, KO_2, KO_3
* **WT samples:** WT_1, WT_2, WT_3

Each sample includes `_1` and `_2` files corresponding to paired-end reads.

---

## 6. Remove unnecessary directories

```bash
rm -r raw_data/chr21_data
```

Removes the leftover nested directory after file reorganization, keeping the project structure clean.

---

## Final Directory Structure

```text
raw_data/
├── KO_1_SRR10045016_1.fastq.gz
├── KO_1_SRR10045016_2.fastq.gz
├── KO_2_SRR10045017_1.fastq.gz
├── KO_2_SRR10045017_2.fastq.gz
├── KO_3_SRR10045018_1.fastq.gz
├── KO_3_SRR10045018_2.fastq.gz
├── WT_1_SRR10045019_1.fastq.gz
├── WT_1_SRR10045019_2.fastq.gz
├── WT_2_SRR10045020_1.fastq.gz
├── WT_2_SRR10045020_2.fastq.gz
├── WT_3_SRR10045021_1.fastq.gz
└── WT_3_SRR10045021_2.fastq.gz
```

---

## Notes

* Raw FASTQ files are **not modified** at this stage
* All downstream steps (QC, trimming, mapping) use this directory as input
* Original data source: Zenodo (GSE136366)
