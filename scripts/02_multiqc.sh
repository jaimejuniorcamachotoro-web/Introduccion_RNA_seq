#!/usr/bin/env bash

# Generación del informe conjunto de calidad
# Herramienta: MultiQC
# Requiere la función multiqc configurada en Git Bash

# Crear carpeta de resultados
mkdir -p Output/MultiQC

# Reunir los informes generados por FastQC
multiqc Output/FastQC/ -o Output/MultiQC/