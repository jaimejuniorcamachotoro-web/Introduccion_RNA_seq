# ============================================================
# 03. NORMALIZACION Y ANALISIS CON DESEQ2
# Proyecto: Analisis RNA-seq
# ============================================================

library(DESeq2)

# ------------------------------------------------------------
# 1. Preparacion de la variable de tratamiento
# ------------------------------------------------------------

# Convertir Treatment en variable categorica
se$Treatment <- factor(se$Treatment)

# Comprobar la cantidad de muestras por tratamiento
table(se$Treatment)

# ------------------------------------------------------------
# 2. Construccion del objeto DESeqDataSet
# ------------------------------------------------------------

dds <- DESeqDataSet(
  se,
  design = ~ Treatment
)

# ------------------------------------------------------------
# 3. Prefiltrado de transcritos con cuentas bajas
# ------------------------------------------------------------

keep <- rowSums(counts(dds) >= 3) >= 6

dds <- dds[keep, ]

# ------------------------------------------------------------
# 4. Normalizacion y analisis de expresion diferencial
# ------------------------------------------------------------

dds <- DESeq(dds)

# ------------------------------------------------------------
# 5. Inspeccion de resultados
# ------------------------------------------------------------

# Dimensiones del objeto despues del filtrado
dim(dds)

# Primeros valores de las cuentas normalizadas
head(counts(dds, normalized = TRUE)[, 1:3])
