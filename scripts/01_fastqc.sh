#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/00_funcion_fastqc_windows.sh"

# Control de calidad de RNA-seq con FastQC
# Ejecutado en Git Bash desde la carpeta del minicurso
# Requiere la función fastqc configurada previamente

# Crear carpeta de resultados
mkdir -p Output/FastQC

# Analizar todos los archivos FASTQ comprimidos
fastqc Datos/Archivo_fast/*.fastq.gz -o Output/FastQC/