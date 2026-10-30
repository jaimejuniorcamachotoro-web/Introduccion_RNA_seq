\# Introduction to RNA-seq Analysis



\*\*Author:\*\* Jaime Junior Camacho Toro



This repository documents my learning process and implementation of the introductory RNA-seq minicourse by Comunidad BioInfo (2021).



The project covers the main stages of an RNA-seq analysis workflow, from raw sequencing data quality control to transcript quantification and differential expression analysis.



\## Objectives



\- Understand RNA-seq data processing and analysis.

\- Perform sequencing quality control.

\- Quantify transcript abundance.

\- Explore gene expression patterns.

\- Identify differentially expressed transcripts.



\## Bioinformatics Tools



| Tool | Purpose |

|---|---|

| FastQC | Sequencing quality control |

| MultiQC | Aggregation and visualization of quality control reports |

| Salmon | Transcript-level quantification |

| tximeta | Import and annotation of transcript quantifications |

| SummarizedExperiment | Structured storage and exploration of genomic data |

| DESeq2 | Differential expression analysis |

| PCAtools | Principal component analysis |

| ggplot2 | Data visualization |

| pheatmap | Heatmap generation |



\## Dataset



The analysis includes 12 paired-end RNA-seq samples corresponding to:



\- \*\*Cell lines:\*\* A and M.

\- \*\*Experimental conditions:\*\* Control and Verafinib.



\## Workflow



1\. \*\*Quality Control:\*\* FastQC and MultiQC.

2\. \*\*Transcript Quantification:\*\* Salmon.

3\. \*\*Data Import and Exploration:\*\* tximeta and SummarizedExperiment.

4\. \*\*Normalization and Differential Expression:\*\* DESeq2.

5\. \*\*Exploratory Analysis and Visualization:\*\* PCAtools, MA plots, Volcano plots and Heatmaps.



\## Repository Structure



```text

Introduccion\_RNA\_seq/

├── bin/

├── docs/

├── results/

│   ├── FastQC/

│   ├── MultiQC/

│   ├── Salmon/

│   └── R/

├── scripts/

│   └── R/

└── README.md

```



\## Reproducibility



The repository includes analysis scripts, original course-related functions, quality control reports, Salmon quantification outputs and R-generated figures.



The original R analysis code is preserved alongside the scripts organized by workflow stage.



Raw FASTQ files and the Salmon reference index are not included in the repository.



\## Reference



Comunidad BioInfo (2021). \*Introductory RNA-seq Minicourse.\*

