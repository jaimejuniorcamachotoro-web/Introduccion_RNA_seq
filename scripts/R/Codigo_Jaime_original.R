library(tximeta)
library(SummarizedExperiment)
library(ggplot2)
library(DESeq2)
proyecto <- "C:/Users/jaime/OneDrive/Documents/codigos/Curso introductorio RNA-seq/minicurso_abr_2021-main"

dir.exists(proyecto)

list.files(file.path(proyecto, "Output", "salmon_quant"))

# file.exists(file.path(proyecto, "Output", "salmon_quant", "metadata.txt"))


# Lectura de los datos
#Esto lo que hace es convertir la tabla de metadatos en algo leible
coldata <- read.delim(
  here::here("Datos/Archivo_salmon/metadata.txt")
)

#Cambiamos el nombre de la columna unique_id

coldata <- dplyr::rename(coldata, names = unique_id)
rownames(coldata) <- coldata$names
coldata

#Conectamos los datos
dir <- here::here("Output", "salmon_quant")

coldata$files <- file.path(
  dir,
  paste0(coldata$Sample, "_quant"),
  "quant.sf"
)

#Commprobacion de la nueva columna
data.frame(
  Sample = coldata$Sample,
  existe = file.exists(coldata$files)
)

# Ampliamos el tiempo permitido para las descargas
options(timeout = 600)

# Importamos los datos evitando FTP
se <- tximeta(coldata, skipFtp = TRUE)

#####################################################################

# Visualizamos los metadatos
colData(se)

# Consultamos el tipo de objeto
class(colData(se))

# Consultamos los identificadores de las muestras
rownames(colData(se))

##Explorar rowRanges: la ubicación genómica
# Mostramos las primeras cinco anotaciones
head(rowRanges(se), 5)

# Consultamos información sobre los cromosomas
seqinfo(rowRanges(se))

##Explorar assays: las cuantificaciones de Salmon
# Consultamos las matrices disponibles
assayNames(se)

# Fragmentos estimados por transcrito
assay(se, "counts")[1:5, 1:3]

# Abundancias normalizadas en TPM
assay(se, "abundance")[1:5, 1:3]

# Longitudes efectivas
assay(se, "length")[1:5, 1:3]

##Comprobamos que los metadatos corresponden a las muestras correctas
rownames(colData(se)) == colnames(assay(se))

########################################################
#Noramalizacion de datos
library(DESeq2)
se$Treatment <- factor(se$Treatment)

table(se$Treatment)

dds <- DESeqDataSet(se, design = ~ Treatment)

keep <- rowSums(counts(dds) >= 3) >= 6
dds <- dds[keep, ]

dds <- DESeq(dds)

dim(dds)
head(counts(dds, normalized = TRUE)[, 1:3])

library(DESeq2)

# Transformación logarítmica regularizada
rld <- rlog(dds, blind = FALSE)
# PCA utilizando DESeq2
plotPCA(rld, intgroup = "Treatment")
plotPCA(rld, intgroup = "Cell")
plotPCA(rld, intgroup = c("Treatment", "Cell"))

# Cargamos PCAtools
library(PCAtools)

# Calculamos el PCA
PCA <- pca(
  assay(rld),
  scale = TRUE,
  metadata = colData(rld)
)

# Visualizamos el PCA
biplot(PCA, colby = "Treatment")

# PCA con los nombres de las muestras
biplot(
  PCA,
  lab = colnames(assay(rld)),
  colby = "Treatment",
  legendPosition = "right"
)

# Visualizamos la varianza de los componentes
screeplot(PCA)

# Obtener los resultados de expresión diferencial
res <- results(dds)

# Visualizar los resultados
res

# Obtener un resumen del análisis
summary(res)

# Información sobre las columnas
mcols(res, use.names = TRUE)

# Evaluamos cambios de expresión superiores a dos veces
resLFC1 <- results(dds, lfcThreshold = 1)

# Contamos los resultados significativos
table(resLFC1$padj < 0.1)

# Visualizamos las diferencias de expresión
plotMA(res)

# Estimación estabilizada del log2FoldChange
res_lfc <- lfcShrink(
  dds,
  coef = "Treatment_Verafinib_vs_Control",
  type = "apeglm"
)

plotMA(res_lfc)

# Convertimos los resultados a data.frame
DEG <- as.data.frame(res)

# Buscamos el archivo de funciones
funciones <- list.files(
  here::here(),
  pattern = "^functions\\.R$",
  recursive = TRUE,
  full.names = TRUE
)

funciones

#Buscar funcion en R

# Cargar las bibliotecas que necesita la función
library(dplyr)
library(tidyr)

# Cargar la función de la docente
source(here::here("bin", "functions.R"))

exists("volcanoplotR")

# Generar el Volcano plot original
volcanoplotR(DEG, logfc = 0, p.adj = 0.1, type = "DESeq")

#Confirmación de los 12 datos
library(dplyr)

significant <- DEG %>%
  filter(
    log2FoldChange > 0 & padj < 0.1 |
      log2FoldChange < 0 & padj < 0.1
  )

norm_counts <- counts(dds, normalized = TRUE)
norm_counts <- norm_counts[rownames(significant), ]

dim(norm_counts)

#Heatmap
# Guardamos los transcritos con expresión diferencial significativa
significant <- DEG %>%
  filter(
    log2FoldChange > 0 & padj < 0.1 |
      log2FoldChange < 0 & padj < 0.1
  )

# Obtenemos las cuentas normalizadas
norm_counts <- counts(dds, normalized = TRUE)

# Conservamos solamente los transcritos significativos
norm_counts <- norm_counts[rownames(significant), ]

##Preparar datos y generar el heatmap

# Cargamos la biblioteca
library(pheatmap)

# Anotaciones de las muestras
annotation_col <- coldata[, c(2, 3)]

# Generamos el heatmap
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

