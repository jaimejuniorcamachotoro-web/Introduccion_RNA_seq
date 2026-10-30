#!/usr/bin/env bash

# Cargar nuestra función personalizada de MultiQC
source "$(dirname "${BASH_SOURCE[0]}")/00_funcion_multiqc_windows.sh"

# Generación del informe conjunto de calidad
# Herramienta: MultiQC

# Crear carpeta de resultados
mkdir -p Output/MultiQC

# Integrar los informes individuales de FastQC
multiqc Output/FastQC/ -o Output/MultiQC/