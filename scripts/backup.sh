#!/bin/bash

# Verificar si se proporcionó un directorio
if [ -z "$1" ]; then
  echo "Por favor, proporciona un directorio como parámetro."
  exit 1
fi

# Comprimir el directorio proporcionado
DIRECTORIO=$1
ARCHIVO_COMPRIMIDO="backup_$(basename $DIRECTORIO)_$(date +%Y%m%d_%H%M%S).tar.gz"

# Crear el backup en el directorio respaldo
tar -czf ~/laboratorio/respaldo/$ARCHIVO_COMPRIMIDO -C $(dirname $DIRECTORIO) $(basename $DIRECTORIO)

# Mostrar mensaje de éxito y el tamaño del archivo creado
echo "Backup exitoso: ~/laboratorio/respaldo/$ARCHIVO_COMPRIMIDO"
echo "Tamaño del archivo: $(du -sh ~/laboratorio/respaldo/$ARCHIVO_COMPRIMIDO | cut -f1)"
