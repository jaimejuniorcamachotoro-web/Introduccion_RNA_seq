
# Configuración de FastQC en Windows

## 1. Herramienta utilizada

FastQC v0.13.0 para el control de calidad de lecturas de RNA-seq.

Entorno de trabajo:
- Windows 11
- Git Bash desde la terminal de RStudio
- Java para ejecutar FastQC

## 2. Configuración

FastQC se configuró mediante una función personalizada de Bash, guardada en el archivo ~/.bashrc.

Esta función permite ejecutar FastQC desde la terminal sin escribir manualmente toda la instrucción de Java.

Para cargar la configuración:

```bash
source ~/.bashrc
```

## 3. Ejecución del análisis

Desde el directorio principal del minicurso:

```bash
mkdir -p Output/FastQC

fastqc Datos/Archivo_fast/*.fastq.gz -o Output/FastQC/
```

El patrón *.fastq.gz permite seleccionar todos los archivos FASTQ comprimidos de la carpeta.

## 4. Resultados

Los informes individuales de calidad se almacenan en:

Output/FastQC/

Estos informes se utilizaron posteriormente para generar un reporte conjunto mediante MultiQC.

## 5. Nota de reproducibilidad

La función fastqc depende de la instalación local de Java y FastQC. Para ejecutar el análisis en otra computadora es necesario adaptar su configuración.
