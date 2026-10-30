#!/usr/bin/env bash

# Construcción del índice de Salmon
# Referencia: GENCODE v37
# Salmon v1.10.3

salmon index \
  -t Reference/gencode.v37.transcripts.fa.gz \
  -i Reference/salmon_index_v1.10.3_k25 \
  --gencode \
  -k 25 \
  -p 4
