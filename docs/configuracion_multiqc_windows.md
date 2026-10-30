
# Configuración de MultiQC en Windows

## 1. Herramienta utilizada

MultiQC permite reunir los informes individuales de FastQC en un único reporte de calidad.

Entorno de trabajo:
- Windows 11
- Python 3.12
- Git Bash desde RStudio

## 2. Instalación

Se creó un entorno virtual de Python para instalar MultiQC.

```bash
"/c/Users/jaime/AppData/Local/Programs/Python/Python312/python.exe" -m venv "/c/Users/jaime/.venvs/multiqc"
```

Posteriormente se instaló MultiQC:

```bash
"/c/Users/jaime/.venvs/multiqc/Scripts/python.exe" -m pip install multiqc
```

## 3. Configuración en Git Bash

Se añadió la siguiente función al archivo ~/.bashrc:

```bash
multiqc() {
    "/c/Users/jaime/.venvs/multiqc/Scripts/python.exe" -m multiqc "$@"
}
```

Esto permite ejecutar MultiQC directamente desde la terminal.

## 4. Ejecución del análisis

Desde la carpeta principal del minicurso:

```bash
mkdir -p Output/MultiQC

multiqc Output/FastQC/ -o Output/MultiQC/
```

## 5. Resultados

MultiQC integra los resultados de FastQC en un informe HTML que facilita la comparación de calidad entre muestras.

Los resultados se almacenan en:

Output/MultiQC/

## 6. Nota de reproducibilidad

Las rutas del entorno virtual corresponden a la computadora original y deben adaptarse para utilizar MultiQC en otro equipo.
