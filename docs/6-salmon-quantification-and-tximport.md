# Transcript Quantification with Salmon and Gene-level Aggregation

This document describes transcript-level quantification using **Salmon** and aggregation to gene-level counts using **tximport** for chromosome 21 RNA-seq data.

All steps were performed on trimmed paired-end reads.

---

## 1. Build Salmon index (chromosome 21 transcriptome)

```bash
salmon index \
    -t references/transcriptome_chr21.fa \
    -i references/salmon_index \
    --threads 4
```

* Builds a Salmon index using the chromosome 21 transcriptome
* Index stored in `references/salmon_index/`
* Used for lightweight transcriptome mapping

---

## 2. Quantify transcripts for each sample

```bash
SAMPLES="KO_1_SRR10045016 KO_2_SRR10045017 KO_3_SRR10045018 WT_1_SRR10045019 WT_2_SRR10045020 WT_3_SRR10045021"

for SAMPLE in $SAMPLES; do
    SHORT_NAME=$(echo $SAMPLE | cut -d'_' -f1,2)

    salmon quant \
        -i references/salmon_index \
        -l A \
        -1 trimmed_data/${SAMPLE}_1.trimmed.fastq.gz \
        -2 trimmed_data/${SAMPLE}_2.trimmed.fastq.gz \
        -o salmon_quant/${SHORT_NAME} \
        --threads 4 \
        --validateMappings \
        --gcBias \
        --seqBias \
        2>> logs/salmon.log
done
```

* `-l A`: automatic library type detection
* Bias correction enabled (`--gcBias`, `--seqBias`)
* Output written to `salmon_quant/<sample>/`

---

## 3. Salmon output files

Each sample directory contains:

```text
salmon_quant/
├── KO_1/
├── KO_2/
├── KO_3/
├── WT_1/
├── WT_2/
└── WT_3/
```

Key file per sample:

* `quant.sf` – transcript-level quantification

Columns in `quant.sf`:

| Column          | Description             |
| --------------- | ----------------------- |
| Name            | Transcript ID           |
| Length          | Transcript length       |
| EffectiveLength | Bias-corrected length   |
| TPM             | Transcripts Per Million |
| NumReads        | Estimated read count    |

---

## 4. Mapping rates

Mapping rates were extracted from Salmon logs:

| Sample | Mapping rate (%) |
| ------ | ---------------- |
| KO_1   | 61.35            |
| KO_2   | 52.58            |
| KO_3   | 59.96            |
| WT_1   | 61.18            |
| WT_2   | 47.26            |
| WT_3   | 54.10            |

**Observation:**
Mapping rates of 47–61% are expected for Salmon quantification against a chromosome 21–restricted transcriptome, as the majority of RNA-seq reads originate from transcripts encoded on other chromosomes; similar rates across KO and WT samples indicate consistent library quality and no condition-specific mapping bias.
---

## 5. Create transcript-to-gene mapping (tx2gene)

```bash
awk -F'\t' '$3=="transcript" {
  if (match($9, /gene_id "[^"]+"/)) {
    gene = substr($9, RSTART, RLENGTH)
    sub(/^gene_id "/, "", gene)
    sub(/"$/, "", gene)
  }
  if (match($9, /transcript_id "[^"]+"/)) {
    tx = substr($9, RSTART, RLENGTH)
    sub(/^transcript_id "/, "", tx)
    sub(/"$/, "", tx)
  }
  if (gene && tx) print tx "\t" gene
}' Homo_sapiens.GRCh38.110.chr21.gtf > tx2gene.tsv

sed -i '1i transcript_id\tgene_id' tx2gene.tsv
```

* Extracts transcript–gene relationships from the chromosome 21 GTF
* Used by tximport for gene-level summarization

---

## 6. Aggregate transcript counts to gene level (tximport)

```bash
Rscript scripts/tximport.R
```

tximport outputs:

```text
counts/
├── gene_counts.tsv
├── gene_tpm.tsv
├── sample_info.tsv
└── tximport.rds
```

Summary:

* **3,281 transcripts** imported
* **405 genes** detected on chromosome 21
  
---

## 7. Notes

* Salmon provides fast and bias-aware transcript quantification
* tximport enables gene-level analysis while preserving transcript information
* Chromosome-specific quantification reduces computational cost
* Outputs are ready for DESeq2 / edgeR analysis
