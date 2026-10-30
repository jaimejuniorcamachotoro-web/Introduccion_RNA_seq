# ============================================================
# 07. HEATMAP DE TRANSCRITOS DIFERENCIALMENTE EXPRESADOS
# Proyecto: Analisis RNA-seq
# ============================================================

library(DESeq2)
library(dplyr)
library(pheatmap)

# ------------------------------------------------------------
# 1. Seleccionar transcritos con expresion diferencial
# ------------------------------------------------------------

significant <- DEG %>%
  filter(
    log2FoldChange > 0 & padj < 0.1 |
      log2FoldChange < 0 & padj < 0.1
  )

# ------------------------------------------------------------
# 2. Obtener las cuentas normalizadas
# ------------------------------------------------------------

norm_counts <- counts(dds, normalized = TRUE)

# Conservar solamente los transcritos significativos
norm_counts <- norm_counts[rownames(significant), ]

# ------------------------------------------------------------
# 3. Preparar anotaciones de las muestras
# ------------------------------------------------------------

annotation_col <- coldata[, c(2, 3)]

# ------------------------------------------------------------
# 4. Generar el Heatmap
# ------------------------------------------------------------

pheatmap(
  norm_counts,
  border_color = NA,
  scale = "row",
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "average",
  show_colnames = FALSE,
  show_rownames = FALSE,
  annotation_col = annotation_col
)
