#!/bin/bash

BASE_DIR="$HOME/EPNro1"
ENTRADA="$BASE_DIR/entrada"
SALIDA="$BASE_DIR/salida"
PROCESADO="$BASE_DIR/procesado"

# Verificar variable de entorno
if [ -z "$FILENAME" ]; then
  echo "Error: Debes definir la variable de entorno FILENAME"
  exit 1
fi

ARCHIVO_SALIDA="$SALIDA/$FILENAME.txt"

# Opción -d (borrar entorno)
if [ "$1" == "-d" ]; then
  echo "Eliminando entorno..."
  pkill -f consolidar.sh
  rm -rf "$BASE_DIR"
  echo "Entorno eliminado"
  exit 0
fi

while true; do
  echo "----- MENU -----"
  echo "1) Crear entorno"
  echo "2) Correr proceso"
  echo "3) Listar alumnos por padrón"
  echo "4) Top 10 notas"
  echo "5) Buscar por padrón"
  echo "6) Salir"
  read -p "Elegí una opción: " op

  case $op in

    1)
      mkdir -p "$ENTRADA" "$SALIDA" "$PROCESADO"
      echo "Entorno creado en $BASE_DIR"
      ;;

    2)
      if [ ! -d "$BASE_DIR" ]; then
        echo "Primero debes crear el entorno"
      else
        bash consolidar.sh "$FILENAME" &
        echo "Proceso ejecutándose en background"
      fi
      ;;

    3)
      if [ -f "$ARCHIVO_SALIDA" ]; then
        sort -n "$ARCHIVO_SALIDA"
      else
        echo "No existe el archivo"
      fi
      ;;

    4)
      if [ -f "$ARCHIVO_SALIDA" ]; then
        sort -k5 -nr "$ARCHIVO_SALIDA" | head -n 10
      else
        echo "No existe el archivo"
      fi
      ;;

    5)
      if [ -f "$ARCHIVO_SALIDA" ]; then
        read -p "Ingrese padrón: " padron
        grep "^$padron " "$ARCHIVO_SALIDA"
      else
        echo "No existe el archivo"
      fi
      ;;

    6)
      echo "Saliendo..."
      exit 0
      ;;

    *)
      echo "Opción inválida"
      ;;
  esac

done
