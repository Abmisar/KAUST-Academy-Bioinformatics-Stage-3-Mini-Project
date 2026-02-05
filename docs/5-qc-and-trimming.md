# Quality Control and Read Trimming (Chromosome 21 RNA-seq)

This document describes the quality control (QC), read trimming, and summary steps applied to the raw chromosome 21 RNA-seq FASTQ files.

QC was performed using **FastQC**, **fastp**, and **MultiQC**.

---

## 1. Run FastQC on raw FASTQ files

```bash
cd genomics/

fastqc raw_data/*.fastq.gz -o qc_reports/fastqc_raw -t 4
```

* Generates per-sample QC reports for all raw paired-end FASTQ files
* Output includes both `.html` and `.zip` files
* Reports are stored in `qc_reports/fastqc_raw/`

---

## 2. Verify FastQC output files

```bash
ls -la qc_reports/fastqc_raw/
```

* FastQC reports were successfully generated for all samples
* Each sample has separate reports for R1 and R2
* Total: 12 FastQC reports (6 samples × 2 reads)

---

## 3. Trim reads using fastp

```bash
# Define sample IDs
SAMPLES="KO_1_SRR10045016 KO_2_SRR10045017 KO_3_SRR10045018 WT_1_SRR10045019 WT_2_SRR10045020 WT_3_SRR10045021"

# Process each sample
for SAMPLE in $SAMPLES; do
    fastp \
        --in1 raw_data/${SAMPLE}_1.fastq.gz \
        --in2 raw_data/${SAMPLE}_2.fastq.gz \
        --out1 trimmed_data/${SAMPLE}_1.trimmed.fastq.gz \
        --out2 trimmed_data/${SAMPLE}_2.trimmed.fastq.gz \
        --qualified_quality_phred 20 \
        --length_required 36 \
        --detect_adapter_for_pe \
        --overrepresentation_analysis \
        --thread 4 \
        --json qc_reports/fastp/${SAMPLE}.json \
        --html qc_reports/fastp/${SAMPLE}.html \
        2>> logs/fastp.log
done
```

* Removes low-quality bases (Q < 20)
* Discards reads shorter than 36 bp
* Automatically detects adapters for paired-end data
* Generates per-sample HTML and JSON QC reports
* Logs are appended to `logs/fastp.log`

---

## 4. Compare read counts before and after trimming

```bash
seqkit stats raw_data/*_1.fastq.gz trimmed_data/*_1.trimmed.fastq.gz
```

### Read count comparison (R1 only)

| Sample | Raw reads | Trimmed reads |
| ------ | --------- | ------------- |
| KO_1   | 708,774   | 674,162       |
| KO_2   | 847,301   | 801,335       |
| KO_3   | 725,979   | 665,017       |
| WT_1   | 780,052   | 739,945       |
| WT_2   | 1,085,590 | 1,024,182     |
| WT_3   | 835,263   | 763,427       |

* Read length before trimming: 76 bp
* Read length after trimming: 36–76 bp
* Moderate read loss consistent with quality filtering

---

## 5. Run FastQC on trimmed FASTQ files

```bash
fastqc trimmed_data/*.fastq.gz -o qc_reports/fastqc_trimmed -t 4
```

* Generates FastQC reports for all trimmed FASTQ files
* Used to confirm improvements after trimming

---

## 6. Aggregate QC reports using MultiQC

```bash
multiqc qc_reports/ -o qc_reports -n multiqc_all --force
```

* Aggregates FastQC and fastp reports into a single summary
* Outputs:

  * `qc_reports/multiqc_all.html`
  * `qc_reports/multiqc_all_data/`

---

## Final QC Directory Structure

```text
qc_reports/
├── fastqc_raw/
├── fastqc_trimmed/
├── fastp/
├── multiqc_all.html
└── multiqc_all_data/
```

---

## Notes

* The QC reports are uploaded to the repo
* QC was performed on both **raw** and **trimmed** reads
* Trimming reduced low-quality bases while preserving most reads
* MultiQC provides a unified overview for all samples
* These QC steps ensure data quality before alignment and quantification
