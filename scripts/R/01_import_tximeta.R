
# ============================================================
# 01. IMPORTACION DE CUANTIFICACIONES CON TXIMETA
# Proyecto: Analisis RNA-seq
# ============================================================

library(tximeta)
library(SummarizedExperiment)

# Directorio original del proyecto del minicurso
proyecto <- "C:/Users/jaime/OneDrive/Documents/codigos/Curso introductorio RNA-seq/minicurso_abr_2021-main"

# Verificar directorio del proyecto
dir.exists(proyecto)

# Verificar las cuantificaciones de Salmon
list.files(file.path(proyecto, "Output", "salmon_quant"))

# ------------------------------------------------------------
# 1. Lectura de metadatos
# ------------------------------------------------------------

coldata <- read.delim(
  here::here("Datos/Archivo_salmon/metadata.txt")
)

# Cambiar el nombre de la columna unique_id
coldata <- dplyr::rename(coldata, names = unique_id)

rownames(coldata) <- coldata$names

# Visualizar metadatos
coldata

# ------------------------------------------------------------
# 2. Construccion de rutas a los archivos quant.sf
# ------------------------------------------------------------

dir <- here::here("Output", "salmon_quant")

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
