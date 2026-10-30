# R Analysis Workflow

## Overview

This section documents the analysis of RNA-seq data using R, following the introductory RNA-seq minicourse from Comunidad BioInfo (2021).

The workflow uses Salmon quantification outputs to perform transcript-level data import, exploratory analysis, normalization, differential expression analysis and visualization.

## Software and packages

- R
- tximeta
- SummarizedExperiment
- DESeq2
- ggplot2
- PCAtools
- dplyr
- tidyr
- pheatmap
- apeglm

## Analysis stages

### 1. Transcript quantification import

**Script:** `01_import_tximeta.R`

- Read sample metadata.
- Construct paths to Salmon `quant.sf` files.
- Check file availability.
- Import quantifications using tximeta.

Main object: `se`.

### 2. SummarizedExperiment exploration

**Script:** `02_explore_summarizedexperiment.R`

- Explore sample metadata (`colData`).
- Inspect genomic annotations (`rowRanges`).
- Examine quantification assays (`counts`, `abundance`, `length`).
- Verify sample correspondence.

### 3. Normalization and DESeq2

**Script:** `03_deseq2_normalization.R`

- Define treatment as a categorical variable.
- Construct the DESeqDataSet object.
- Filter transcripts with at least 3 counts in at least 6 samples.
- Perform DESeq2 analysis.
- Inspect normalized counts.

Original design formula: `~ Treatment`.

### 4. Principal Component Analysis

**Script:** `04_pca.R`

- Apply regularized logarithmic transformation (`rlog`).
- Perform PCA using DESeq2 and PCAtools.
- Explore grouping by treatment and cell line.
- Visualize explained variance.

### 5. Differential expression analysis

**Script:** `05_differential_expression.R`

- Extract differential expression results.
- Evaluate log2 fold-change thresholds.
- Generate MA plots.
- Apply log2 fold-change shrinkage using apeglm.

### 6. Volcano plot

**Script:** `06_volcano_plot.R`

- Convert DESeq2 results into a data frame.
- Load the course-provided plotting function.
- Generate a Volcano plot using `volcanoplotR`.

Function source: `bin/functions.R`.

### 7. Heatmap

**Script:** `07_heatmap.R`

- Select transcripts with adjusted p-value below 0.1 and nonzero log2 fold change.
- Retrieve normalized counts.
- Prepare sample annotations.
- Generate a heatmap using pheatmap.

## Original analysis

The original R code is preserved separately as:

`scripts/R/Codigo_Jaime_original.R`

The numbered scripts organize the analysis into stages without replacing the original record of the work.

## Methodological note

The original DESeq2 design was `~ Treatment`. Although the dataset includes two cell lines, the model does not explicitly include Cell or the Treatment:Cell interaction.

This design is preserved to document the original minicourse workflow. A separate methodological assessment is necessary before using it as the final biological model.

## Reproducibility notes

- Salmon quantification results are documented separately in `results/Salmon/`.
- The course-provided `functions.R` file is retained in `bin/`.
- The original analysis uses project-relative paths through `here::here()` and an explicitly defined project directory.
- The scripts have been separated for documentation; their execution from the new repository still requires consistent project paths and dependencies.
- The original code generates plots in the active R session but does not explicitly export them as image files.