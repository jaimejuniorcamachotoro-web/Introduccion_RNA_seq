#!/usr/bin/env bash

# Cuantificación automatizada de las muestras S2 a S12
# Salmon v1.10.3
# Datos paired-end: R1 y R2

for n in {2..12}; do

    echo "Cuantificando muestra s${n}"

    salmon quant \
      -i Reference/salmon_index_v1.10.3_k25 \
      -l A \
      -1 "Datos/Archivo_fast/s${n}_R1.fastq.gz" \
      -2 "Datos/Archivo_fast/s${n}_R2.fastq.gz" \
      --validateMappings \
      -p 4 \
      -o "Output/salmon_quant/s${n}_quant" || break

done
