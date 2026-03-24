#!/bin/bash

BASE_DIR="$HOME/EPNro1"
ENTRADA="$BASE_DIR/entrada"
SALIDA="$BASE_DIR/salida"
PROCESADO="$BASE_DIR/procesado"

FILENAME=$1
ARCHIVO_SALIDA="$SALIDA/$FILENAME.txt"

touch "$ARCHIVO_SALIDA"

while true; do
  for archivo in "$ENTRADA"/*.txt; do
    [ -e "$archivo" ] || continue

    cat "$archivo" >> "$ARCHIVO_SALIDA"
    mv "$archivo" "$PROCESADO"
  done

  sleep 5
done
