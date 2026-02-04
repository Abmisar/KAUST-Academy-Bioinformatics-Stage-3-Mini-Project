\# Reference Genome and Annotation Download (Chromosome 21)



This document describes the terminal commands used to download and prepare the reference genome FASTA, gene annotation (GTF), and cDNA FASTA files for chromosome 21 from Ensembl.  

All reference files use \*\*GRCh38, Ensembl release 110\*\*, matching the lab environment.



---



\## 1. Navigate to the references directory



```bash

cd genomics/references/

````



All reference genomes and annotation files are stored in a dedicated `references/` directory to keep them separate from raw sequencing data.



---



\## 2. Download the chromosome 21 genomic FASTA



```bash

wget https://ftp.ensembl.org/pub/release-110/fasta/homo\_sapiens/dna/Homo\_sapiens.GRCh38.dna.chromosome.21.fa.gz

```



Downloads the \*\*chromosome 21 DNA sequence\*\* from Ensembl (GRCh38, release 110).



---



\## 3. Decompress the FASTA file



```bash

gunzip Homo\_sapiens.GRCh38.dna.chromosome.21.fa.gz

```



Extracts the compressed FASTA file for use in genome-based alignment (e.g., STAR).



---



\## 4. Download the full gene annotation (GTF)



```bash

wget https://ftp.ensembl.org/pub/release-110/gtf/homo\_sapiens/Homo\_sapiens.GRCh38.110.gtf.gz

gunzip Homo\_sapiens.GRCh38.110.gtf.gz

```



Downloads and extracts the \*\*full human gene annotation\*\* file from Ensembl, containing annotations for all chromosomes.



---



\## 5. Subset the GTF to chromosome 21



```bash

grep -E "^#|^21        " Homo\_sapiens.GRCh38.110.gtf > Homo\_sapiens.GRCh38.110.chr21.gtf

```



\* Retains all header lines (`#`)

\* Extracts only annotation entries corresponding to \*\*chromosome 21\*\*

\* Produces a chromosome-specific GTF file for downstream analysis



---



\## 6. Download the full cDNA FASTA file



```bash

wget https://ftp.ensembl.org/pub/release-110/fasta/homo\_sapiens/cdna/Homo\_sapiens.GRCh38.cdna.all.fa.gz

```



Downloads the \*\*complete cDNA (transcriptome) FASTA\*\* for GRCh38, containing transcripts from all chromosomes.



---



\## 7. Extract chromosome 21 transcripts



```bash

gunzip -c Homo\_sapiens.GRCh38.cdna.all.fa.gz | \\

awk '/^>/ {keep = /chromosome:GRCh38:21:/} keep' > transcriptome\_chr21.fa

```



\* Streams the compressed FASTA without fully decompressing it

\* Filters transcripts that map to \*\*chromosome 21\*\*

\* Outputs a chromosome-specific transcriptome FASTA

\* Used for transcriptome-based quantification tools (e.g., Salmon)



---



\## 8. Remove the original large files



```bash

rm Homo\_sapiens.GRCh38.110.gtf

rm Homo\_sapiens.GRCh38.cdna.all.fa.gz

```



\* Deletes the full GTF and complete cDNA FASTA after creating chromosome 21-specific files

\* Keeps the project directory \*\*clean\*\* and saves disk space

\* Ensures only the files needed for downstream analysis remain



---



\## Final Reference Files



```text

references/

├── Homo\_sapiens.GRCh38.dna.chromosome.21.fa

├── Homo\_sapiens.GRCh38.110.chr21.gtf

└── transcriptome\_chr21.fa

```



---



\## Notes



\* All reference files use \*\*GRCh38 (Ensembl release 110)\*\* to ensure consistency

\* Genome FASTA + GTF are used for genome-based alignment

\* cDNA FASTA is used for transcriptome-based quantification

\* Chromosome-specific files reduce computational overhead and simplify analysis



````

