# ============================================================
# 04. ANALISIS DE COMPONENTES PRINCIPALES (PCA)
# Proyecto: Analisis RNA-seq
# ============================================================

library(DESeq2)
library(PCAtools)

# ------------------------------------------------------------
# 1. Transformacion logaritmica regularizada
# ------------------------------------------------------------

rld <- rlog(dds, blind = FALSE)

# ------------------------------------------------------------
# 2. PCA utilizando DESeq2
# ------------------------------------------------------------

# Agrupacion por tratamiento
plotPCA(rld, intgroup = "Treatment")

# Agrupacion por linea celular
plotPCA(rld, intgroup = "Cell")

# Agrupacion por tratamiento y linea celular
plotPCA(rld, intgroup = c("Treatment", "Cell"))

# ------------------------------------------------------------
# 3. Analisis PCA utilizando PCAtools
# ------------------------------------------------------------

PCA <- pca(
  assay(rld),
  scale = TRUE,
  metadata = colData(rld)
)

# ------------------------------------------------------------
# 4. Visualizacion del PCA
# ------------------------------------------------------------

# PCA agrupado por tratamiento
biplot(PCA, colby = "Treatment")

# PCA con nombres de las muestras
biplot(
  PCA,
  lab = colnames(assay(rld)),
  colby = "Treatment",
  legendPosition = "right"
)

# ------------------------------------------------------------
# 5. Visualizacion de la varianza explicada
# ------------------------------------------------------------

screeplot(PCA)
