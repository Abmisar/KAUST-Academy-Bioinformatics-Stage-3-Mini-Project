# Raw Sequencing Data Statistics (Chromosome 21 RNA-seq)

This document describes terminal commands used to summarize the raw FASTQ sequencing data using **SeqKit**.

---

## 1. Navigate to the project directory

```bash
cd genomics/
````

---

## 2. Generate statistics for all FASTQ files

```bash
seqkit stats -a raw_data/*.fastq.gz --threads 8 > seqkit_stats.tsv
```

* `-a`: includes all statistics (reads, bases, Q30, GC%, etc.)
* `--threads 8`: uses 8 CPU threads for faster processing
* Output written to `seqkit_stats.tsv` for downstream inspection

---

## 3. Total reads per sample

| Sample | R1 reads  | R2 reads  | Total reads |
| ------ | --------- | --------- | ----------- |
| KO_1   | 708,774   | 708,774   | 1,417,548   |
| KO_2   | 847,301   | 847,301   | 1,694,602   |
| KO_3   | 725,979   | 725,979   | 1,451,958   |
| WT_1   | 780,052   | 780,052   | 1,560,104   |
| WT_2   | 1,085,590 | 1,085,590 | 2,171,180   |
| WT_3   | 835,263   | 835,263   | 1,670,526   |

---

## 4. Average total reads per condition

* **KO average total reads:**
  [(1,417,548 + 1,694,602 + 1,451,958) / 3 ≈ 1,521,369]

* **WT average total reads:**
  [(1,560,104 + 2,171,180 + 1,670,526) / 3 ≈ 1,800,603]

---

## 5. Other metrics

* **Average read length:** 76 bp (identical for R1 and R2)

* **GC content (average of R1 + R2):**

| Sample | GC%   |
| ------ | ----- |
| KO_1   | 53.91 |
| KO_2   | 55.58 |
| KO_3   | 54.79 |
| WT_1   | 54.12 |
| WT_2   | 55.76 |
| WT_3   | 55.54 |

* **Q30% (average of R1 + R2):**

| Sample | Q30%  |
| ------ | ----- |
| KO_1   | 91.81 |
| KO_2   | 93.50 |
| KO_3   | 84.09 |
| WT_1   | 91.86 |
| WT_2   | 91.34 |
| WT_3   | 84.55 |

---

## 6. Observations

* **Total reads:** WT samples have slightly higher sequencing depth than KO (avg 1.8M vs 1.52M reads)
* **Read length:** identical across all samples (76 bp)
* **GC content:** minor differences between KO (~54.1%) and WT (~55.1%)
* **Q30%:** high quality overall; KO_3 and WT_3 slightly lower (~84%)

**Comment:** Any notable differences between conditions?

> Overall, the raw sequencing data are comparable between KO and WT conditions.
