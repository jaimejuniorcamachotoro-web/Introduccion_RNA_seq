#!/usr/bin/env bash

# Función personalizada de FastQC para Git Bash en Windows
# FastQC v0.13.0
# Configuración original del proyecto RNA-seq

fastqc() {
    local base="C:/Users/jaime/OneDrive/Documents/codigos/FastQC/FastQC"
    local salida=""
    local -a archivos=() opciones=()

    case "${1:-}" in
        -v|--version)
            java -cp "$base;$base/*" \
                -Dfastqc.show_version=true \
                uk.ac.babraham.FastQC.FastQCApplication
            return
            ;;
        -h|--help)
            echo "Uso: fastqc archivo1 [archivo2 ...] -o carpeta_salida"
            return
            ;;
    esac

    while (($#)); do
        case "$1" in
            -o|--outdir)
                if (($# < 2)); then
                    echo "Falta carpeta de salida"
                    return 2
                fi
                salida="$2"
                shift 2
                ;;
            --outdir=*)
                salida="${1#*=}"
                shift
                ;;
            -*)
                echo "Opcion no admitida por este atajo: $1"
                return 2
                ;;
            *)
                if [[ ! -f "$1" ]]; then
                    echo "Archivo no encontrado: $1"
                    return 2
                fi
                archivos+=("$(cygpath -am "$1")")
                shift
                ;;
        esac
    done

    if ((${#archivos[@]} == 0)); then
        echo "Indica al menos un archivo"
        return 2
    fi

    if [[ -n "$salida" ]]; then
        if [[ ! -d "$salida" ]]; then
            echo "Carpeta de salida no encontrada: $salida"
            return 2
        fi
        opciones+=("-Dfastqc.output_dir=$(cygpath -am "$salida")")
    fi

    java -Xmx1024m \
        -Dfastqc.threads=1 \
        -Djava.awt.headless=true \
        "${opciones[@]}" \
        -cp "$base;$base/*" \
        uk.ac.babraham.FastQC.FastQCApplication \
        "${archivos[@]}"
}
