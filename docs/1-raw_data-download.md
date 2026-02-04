\# Raw Data Download and Organization



This document describes the terminal commands used to download, extract, and organize the raw RNA-seq data for the chromosome 21 TDP-43 knockout analysis. All steps were performed on a Linux environment.



---



\## 1. Navigate to the project directory



```bash

cd genomics

````



Moves into the main project directory where all analysis files are stored.



---



\## 2. Download the RNA-seq dataset



```bash

wget https://zenodo.org/records/18481303/files/chr21\_data.zip

```



Downloads the chromosome 21 RNA-seq dataset from Zenodo.

The archive (~586 MB) contains paired-end FASTQ files for wild-type (WT) and TDP-43 knockout (KO) samples.



---



\## 3. Extract the archive and rename the directory



```bash

unzip chr21\_data.zip \&\& mv chr21\_data raw\_data

```



\* Extracts the compressed archive

\* Renames the extracted directory to `raw\_data`, following common bioinformatics conventions



---



\## 4. Move FASTQ files to the main `raw\_data` directory



```bash

mv raw\_data/chr21\_data/raw\_data/\* raw\_data/

```



Moves all raw FASTQ files into the top-level `raw\_data/` directory to simplify downstream processing.



---



\## 5. Verify FASTQ files



```bash

ls raw\_data/

```



The directory now contains 12 paired-end FASTQ files representing 3 biological replicates per condition:



\* \*\*KO samples:\*\* KO\_1, KO\_2, KO\_3

\* \*\*WT samples:\*\* WT\_1, WT\_2, WT\_3



Each sample includes `\_1` and `\_2` files corresponding to paired-end reads.



---



\## 6. Remove unnecessary directories



```bash

rm -r raw\_data/chr21\_data

```



Removes the leftover nested directory after file reorganization, keeping the project structure clean.



---



\## Final Directory Structure



```text

raw\_data/

├── KO\_1\_SRR10045016\_1.fastq.gz

├── KO\_1\_SRR10045016\_2.fastq.gz

├── KO\_2\_SRR10045017\_1.fastq.gz

├── KO\_2\_SRR10045017\_2.fastq.gz

├── KO\_3\_SRR10045018\_1.fastq.gz

├── KO\_3\_SRR10045018\_2.fastq.gz

├── WT\_1\_SRR10045019\_1.fastq.gz

├── WT\_1\_SRR10045019\_2.fastq.gz

├── WT\_2\_SRR10045020\_1.fastq.gz

├── WT\_2\_SRR10045020\_2.fastq.gz

├── WT\_3\_SRR10045021\_1.fastq.gz

└── WT\_3\_SRR10045021\_2.fastq.gz

```



---



\## Notes



\* Raw FASTQ files are \*\*not modified\*\* at this stage

\* All downstream steps (QC, trimming, mapping) use this directory as input

\* Original data source: Zenodo (GSE136366)



```

