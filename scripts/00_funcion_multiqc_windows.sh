#!/usr/bin/env bash

# Función personalizada de MultiQC para Git Bash en Windows
# Utiliza el entorno virtual de Python donde instalamos MultiQC

multiqc() {
    "/c/Users/jaime/.venvs/multiqc/Scripts/python.exe" -m multiqc "$@"
}