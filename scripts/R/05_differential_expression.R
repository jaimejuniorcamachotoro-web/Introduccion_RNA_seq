# ============================================================
# 05. ANALISIS DE EXPRESION DIFERENCIAL
# Proyecto: Analisis RNA-seq
# ============================================================

library(DESeq2)

# ------------------------------------------------------------
# 1. Obtener resultados de expresion diferencial
# ------------------------------------------------------------

res <- results(dds)

# Visualizar los resultados
res

# Obtener un resumen del analisis
summary(res)

# Consultar informacion sobre las columnas
mcols(res, use.names = TRUE)

# ------------------------------------------------------------
# 2. Evaluar cambios de expresion superiores a dos veces
# ------------------------------------------------------------

resLFC1 <- results(dds, lfcThreshold = 1)

# Contar resultados significativos
table(resLFC1$padj < 0.1)

# ------------------------------------------------------------
# 3. Visualizacion mediante MA plot
# ------------------------------------------------------------

plotMA(res)

# ------------------------------------------------------------
# 4. Estimacion estabilizada del log2FoldChange
# ------------------------------------------------------------

res_lfc <- lfcShrink(
  dds,
  coef = "Treatment_Verafinib_vs_Control",
  type = "apeglm"
)

# Visualizar MA plot con LFC ajustado
plotMA(res_lfc)
