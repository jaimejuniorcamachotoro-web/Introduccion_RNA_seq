# ============================================================
# 06. VOLCANO PLOT
# Proyecto: Analisis RNA-seq
# ============================================================

library(ggplot2)
library(dplyr)
library(tidyr)

# ------------------------------------------------------------
# 1. Convertir resultados a data.frame
# ------------------------------------------------------------

DEG <- as.data.frame(res)

# ------------------------------------------------------------
# 2. Cargar funciones proporcionadas en el minicurso
# ------------------------------------------------------------

source(here::here("bin", "functions.R"))

# Comprobar disponibilidad de la funcion
exists("volcanoplotR")

# ------------------------------------------------------------
# 3. Generar Volcano plot
# ------------------------------------------------------------

volcanoplotR(
  DEG,
  logfc = 0,
  p.adj = 0.1,
  type = "DESeq"
)
