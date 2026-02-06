## What is Enrichment Analysis?

Enrichment analysis helps answer the question:
*"What biological processes or pathways are over-represented in my gene list?"*

Key databases:

* **Gene Ontology (GO)** – Standardized vocabulary for gene function

  * **Biological Process (BP):** What the gene does
  * **Molecular Function (MF):** How it does it
  * **Cellular Component (CC):** Where it acts
* **KEGG Pathways:** Maps linking genes to cellular processes

---

## g:Profiler

[g:Profiler](https://biit.cs.ut.ee/gprofiler/) is a widely-used tool for functional enrichment analysis.

* Supports multiple organisms and gene ID types
* Queries GO, KEGG, Reactome, and other databases
* Returns statistical significance with multiple testing correction
* Python package: `gprofiler-official` for programmatic access

---

## Selecting Significant Genes

```python
PADJ_THRESHOLD = 0.05
LOG2FC_THRESHOLD = 1  # |log2FC| > 1 means >2-fold change

# Filter significant genes
sig_genes = de_results[
    (de_results['padj'] < PADJ_THRESHOLD) &
    (de_results['log2FoldChange'].abs() > LOG2FC_THRESHOLD)
].copy()

up_genes = sig_genes[sig_genes['log2FoldChange'] > 0]['gene_id'].tolist()
down_genes = sig_genes[sig_genes['log2FoldChange'] < 0]['gene_id'].tolist()
all_sig_genes = sig_genes['gene_id'].tolist()

print(f"Total: {len(all_sig_genes)}, Upregulated: {len(up_genes)}, Downregulated: {len(down_genes)}")
```

**Output:**

```
Significant genes (padj < 0.05, |log2FC| > 1):
  Total: 7
  Upregulated in KO: 5
  Downregulated in KO: 2
```

---

## Running g:Profiler Enrichment

```python
from gprofiler import GProfiler
gp = GProfiler(return_dataframe=True)

def run_enrichment(gene_list, name, sources=['GO:BP','GO:MF','GO:CC']):
    if len(gene_list) == 0:
        print(f"Warning: {name} gene list is empty!")
        return pd.DataFrame()
    print(f"Running enrichment for {name} ({len(gene_list)} genes)...")
    results = gp.profile(
        organism='hsapiens',
        query=gene_list,
        sources=sources,
        user_threshold=0.05,
        significance_threshold_method='fdr'
    )
    print(f"  Found {len(results)} significant terms" if len(results) > 0 else "  No significant terms found")
    return results

# GO enrichment
go_all = run_enrichment(all_sig_genes, "All significant genes")
go_up = run_enrichment(up_genes, "Upregulated genes")
go_down = run_enrichment(down_genes, "Downregulated genes")

# KEGG enrichment
kegg_all = run_enrichment(all_sig_genes, "All significant genes (KEGG)", sources=['KEGG'])
kegg_up = run_enrichment(up_genes, "Upregulated genes (KEGG)", sources=['KEGG'])
kegg_down = run_enrichment(down_genes, "Downregulated genes (KEGG)", sources=['KEGG'])
```

---

## Results

**Top GO terms for all significant genes:**

| source | native     | name                                  | p_value  | intersection_size |
| ------ | ---------- | ------------------------------------- | -------- | ----------------- |
| GO:CC  | GO:0005589 | collagen type VI trimer               | 0.025592 | 1                 |
| GO:CC  | GO:0098647 | collagen beaded filament              | 0.025592 | 1                 |
| GO:CC  | GO:0140086 | basement membrane/interstitial matrix | 0.025592 | 1                 |

**Top KEGG pathways for all significant genes:**

| native     | name                               | p_value  | intersection_size |
| ---------- | ---------------------------------- | -------- | ----------------- |
| KEGG:03265 | Virion - Ebolavirus and Lyssavirus | 0.029685 | 1                 |
| KEGG:05165 | Human papillomavirus infection     | 0.030863 | 2                 |

---

## GO Enrichment Plots

### GO Enrichment – All Differentially Expressed Genes 

![GO Enrichment - All DE Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/go_all_genes_bar.png)


### GO Enrichment – Upregulated Genes 

![GO Enrichment - Upregulated Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/go_upregulated_bar.png)


### GO Enrichment – Downregulated Genes 

![GO Enrichment - Downregulated Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/go_downregulated_bar.png)

---

## GO Enrichment – All DE Genes (Dot Plot)

![GO Enrichment - All DE Genes Dot Plot](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/go_all_genes_dot.png)

---

## KEGG Pathway Enrichment Plots

### KEGG Pathways – All Differentially Expressed Genes

![KEGG Pathways - All DE Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/kegg_all_bar.png)


### KEGG Pathways – Upregulated Genes

![KEGG Pathways - Upregulated Genes](https://github.com/Raiyan-S/KAUST-Academy-Bioinformatics-Stage-3-Mini-Project/raw/main/genomics/results/enrichment/kegg_up_bar.png)


### KEGG Pathways – Downregulated Genes

No significant KEGG pathways were identified for downregulated genes; therefore, no plot is shown.

---

## Summary

```
Input:
  Total significant genes: 7
  Upregulated: 5
  Downregulated: 2

GO Enrichment:
  All genes: 3 terms
  Upregulated: 3 terms
  Downregulated: 28 terms

KEGG Enrichment:
  All genes: 2 pathways
  Upregulated: 2 pathways
  Downregulated: 0 pathways
```
