# Reference Genome and Transcriptome Statistics (Chromosome 21)

This document describes terminal commands used to compute basic statistics on the chromosome 21 reference genome and transcriptome files.  

Statistics include:

* Number of genes  
* Number of transcripts  
* Number of DNA base pairs  
* Number of transcript nucleotides

---

## 1. Navigate to the references directory

```bash
cd genomics/references/
````

All reference files are stored in this directory.

---

## 2. Count the number of DNA base pairs

```bash
grep -v "^>" Homo_sapiens.GRCh38.dna.chromosome.21.fa | tr -d '\n' | wc -c
```

* Removes FASTA headers (`>` lines)
* Concatenates all sequence lines into one continuous string (`tr -d '\n'`)
* Counts total nucleotides (`wc -c`)

**Result:** 46,709,983 bp

---

## 3. Count the number of genes

```bash
awk '$3 == "gene"' Homo_sapiens.GRCh38.110.chr21.gtf | wc -l
```

* Filters GTF entries with `feature == "gene"`
* Counts total gene entries

**Result:** 898 genes

---

## 4. Count the number of transcripts

```bash
awk '$3 == "transcript"' Homo_sapiens.GRCh38.110.chr21.gtf | wc -l
```

* Filters GTF entries with `feature == "transcript"`
* Counts total transcript entries

**Result:** 3,281 transcripts

---

## 5. Count the number of transcript nucleotides

```bash
grep -v "^>" transcriptome_chr21.fa | tr -d '\n' | wc -c
```

* Removes FASTA headers
* Concatenates all transcript sequences
* Counts total nucleotides

**Result:** 3,726,362 nucleotides

---

## Summary Table

| Reference      | Count      |
| -------------- | ---------- |
| DNA base pairs | 46,709,983 |
| Genes          | 898        |
| Transcripts    | 3,281      |
| Transcript nt  | 3,726,362  |

---

## Notes

* All counts are specific to **chromosome 21**
* Useful for planning alignment and quantification tasks
* Provides a quick sanity check for downloaded reference files
