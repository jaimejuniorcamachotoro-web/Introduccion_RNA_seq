# ============================================================
# 02. EXPLORACION DEL OBJETO SUMMARIZEDEXPERIMENT
# Proyecto: Analisis RNA-seq
# ============================================================

library(SummarizedExperiment)

# ------------------------------------------------------------
# 1. Exploracion de metadatos
# ------------------------------------------------------------

# Visualizar los metadatos de las muestras
colData(se)

# Consultar la clase del objeto
class(colData(se))

# Consultar los identificadores de las muestras
rownames(colData(se))

# ------------------------------------------------------------
# 2. Exploracion de rowRanges: ubicacion genomica
# ------------------------------------------------------------

# Mostrar las primeras cinco anotaciones
head(rowRanges(se), 5)

# Consultar informacion sobre los cromosomas
seqinfo(rowRanges(se))

# ------------------------------------------------------------
# 3. Exploracion de assays: cuantificaciones de Salmon
# ------------------------------------------------------------

# Consultar las matrices disponibles
assayNames(se)

# Fragmentos estimados por transcrito
assay(se, "counts")[1:5, 1:3]

# Abundancias normalizadas en TPM
assay(se, "abundance")[1:5, 1:3]

# Longitudes efectivas
assay(se, "length")[1:5, 1:3]

# ------------------------------------------------------------
# 4. Comprobar correspondencia entre muestras y matrices
# ------------------------------------------------------------

rownames(colData(se)) == colnames(assay(se))
