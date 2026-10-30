# ============================================================
# 01. IMPORTACION DE CUANTIFICACIONES CON TXIMETA
# Proyecto: Analisis RNA-seq
# ============================================================

library(tximeta)
library(SummarizedExperiment)

# Directorio original del proyecto del minicurso
proyecto <- "C:/Users/jaime/OneDrive/Documents/codigos/Introduccion_RNA_seq"

# Verificar directorio del proyecto
dir.exists(proyecto)

# Verificar las cuantificaciones de Salmon
list.files(file.path(proyecto, "results", "Salmon"))

# ------------------------------------------------------------
# 1. Lectura de metadatos
# ------------------------------------------------------------

coldata <- read.delim(
  file.path(proyecto, "Datos", "Archivo_salmon", "metadata.txt")
)

# Cambiar el nombre de la columna unique_id
coldata <- dplyr::rename(coldata, names = unique_id)

rownames(coldata) <- coldata$names

# Visualizar metadatos
coldata

# ------------------------------------------------------------
# 2. Construccion de rutas a los archivos quant.sf
# ------------------------------------------------------------

dir <- file.path(proyecto, "results", "Salmon")

coldata$files <- file.path(
  dir,
  paste0(coldata$Sample, "_quant"),
  "quant.sf"
)

# Comprobar existencia de los archivos
data.frame(
  Sample = coldata$Sample,
  existe = file.exists(coldata$files)
)

# ------------------------------------------------------------
# 3. Importacion mediante tximeta
# ------------------------------------------------------------

# Ampliar el tiempo permitido para las descargas
options(timeout = 600)

# Importar cuantificaciones evitando FTP
se <- tximeta(coldata, skipFtp = TRUE)
