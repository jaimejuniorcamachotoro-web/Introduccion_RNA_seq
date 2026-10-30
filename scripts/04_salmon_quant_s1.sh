#!/usr/bin/env bash

# Cuantificación de la muestra S1 mediante Salmon
# Datos paired-end: R1 y R2
# Salmon v1.10.3

salmon quant \
  -i Reference/salmon_index_v1.10.3_k25 \
  -l A \
  -1 Datos/Archivo_fast/s1_R1.fastq.gz \
  -2 Datos/Archivo_fast/s1_R2.fastq.gz \
  --validateMappings \
  -p 4 \
  -o Output/salmon_quant/s1_quant
