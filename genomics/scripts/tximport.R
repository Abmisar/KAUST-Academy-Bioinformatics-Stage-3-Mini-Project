# =============================================================================
# Aggregate Transcript Counts to Gene Level with tximport
# =============================================================================

library(tximport)

cat("Loading transcript-to-gene mapping...\n")

# Read the tx2gene mapping file
tx2gene <- read.table("~/project/genomics/references/tx2gene.tsv",
                      sep = "\t", header = TRUE)
colnames(tx2gene) <- c("TXNAME", "GENEID")

cat(paste0("  Loaded ", nrow(tx2gene), " transcript-gene pairs\n"))

# Define samples and their quant files
samples <- c("KO_1", "KO_2", "KO_3", "WT_1", "WT_2", "WT_3")
conditions <- c("KO", "KO", "KO", "WT", "WT", "WT")

files <- file.path("~/project/genomics/salmon_quant", samples, "quant.sf")
names(files) <- samples

# Check files exist
cat("Checking quant files...\n")
for (f in files) {
    if (file.exists(f)) {
        cat(paste0("  Found: ", f, "\n"))
    } else {
        stop(paste0("Missing: ", f))
    }
}

# Import with tximport
cat("\nImporting Salmon counts...\n")
txi <- tximport(files, type = "salmon", tx2gene = tx2gene, ignoreTxVersion = TRUE)

cat(paste0("  Imported ", nrow(txi$counts), " genes\n"))

# Create output directory
dir.create("~/project/genomics/counts", showWarnings = FALSE)

# Save count matrix
counts <- as.data.frame(round(txi$counts))
counts$gene_id <- rownames(counts)
counts <- counts[, c("gene_id", samples)]
write.table(counts, "~/project/genomics/counts/gene_counts.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)

# Save TPM matrix
tpm <- as.data.frame(txi$abundance)
tpm$gene_id <- rownames(tpm)
tpm <- tpm[, c("gene_id", samples)]
write.table(tpm, "~/project/genomics/counts/gene_tpm.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)

# Save sample info
sample_info <- data.frame(
    sample_id = samples,
    condition = conditions
)
write.table(sample_info, "~/project/genomics/counts/sample_info.tsv",
            sep = "\t", quote = FALSE, row.names = FALSE)

# Save tximport object for DESeq2
saveRDS(txi, "~/project/genomics/counts/tximport.rds")

cat("\n=== Output files ===\n")
cat("  counts/gene_counts.tsv\n")
cat("  counts/gene_tpm.tsv\n")
cat("  counts/sample_info.tsv\n")
cat("  counts/tximport.rds\n")
cat("\nDone!\n")
