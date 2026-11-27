#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PROFILE=${1:-}
STYLE=${2:-PIXEL}

usage() {
  echo "Uso: sudo sh installers/astral-installer.sh [classic|modern] [PIXEL]"
}

if [ "$(id -u)" -ne 0 ]; then
  echo "Este instalador necesita permisos de administrador." >&2
  echo "Ejecuta: sudo sh installers/astral-installer.sh classic" >&2
  exit 1
fi

if [ -z "$PROFILE" ]; then
  echo "ASTRAL Linux — Instalador"
  echo "1) Classic — equipos modestos compatibles con Ubuntu"
  echo "2) Modern  — equipos actuales"
  printf "Selecciona un perfil [1-2]: "
  read -r answer
  case "$answer" in
    1) PROFILE=classic ;;
    2) PROFILE=modern ;;
    *) echo "Selección no válida." >&2; exit 2 ;;
  esac
fi

case "$PROFILE" in
  classic|modern) ;;
  *) usage; exit 2 ;;
esac

case "$STYLE" in
  PIXEL) ;;
  *)
    echo "El estilo $STYLE todavía no tiene una sesión instalable."
    echo "Por ahora, PIXEL es el primer escritorio funcional."
    exit 3
    ;;
esac

if [ ! -f "$ROOT/scripts/install-pixel.sh" ]; then
  echo "No se encuentra scripts/install-pixel.sh. Ejecuta desde el repositorio completo." >&2
  exit 1
fi

if [ ! -r /etc/os-release ]; then
  echo "No se pudo identificar el sistema operativo." >&2
  exit 1
fi
. /etc/os-release
if [ "${ID:-}" != ubuntu ]; then
  echo "ASTRAL Classic/Modern requiere actualmente una instalación Ubuntu compatible." >&2
  echo "Sistema detectado: ${PRETTY_NAME:-desconocido}" >&2
  exit 4
fi

ARCH=$(dpkg --print-architecture)
if [ "$ARCH" != amd64 ]; then
  echo "Arquitectura no soportada por este instalador: $ARCH (se requiere amd64)." >&2
  echo "La compatibilidad i386/486/Pentium está en investigación Legacy." >&2
  exit 5
fi

MEM_KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
if [ "$PROFILE" = classic ]; then
  MIN_MEM=1800000
  echo "Perfil seleccionado: ASTRAL Classic"
else
  MIN_MEM=3500000
  echo "Perfil seleccionado: ASTRAL Modern"
fi
if [ "$MEM_KB" -lt "$MIN_MEM" ]; then
  echo "Aviso: la RAM detectada está por debajo de la recomendación de este perfil."
  echo "La instalación continuará, pero el rendimiento puede ser limitado."
fi

echo "Escritorio: $STYLE"
echo "Base detectada: ${PRETTY_NAME:-Ubuntu}"
echo
echo "Se instalarán paquetes de escritorio y se crearán archivos de configuración."
echo "No se formatearán particiones ni se modificará el cargador de arranque."
printf "¿Continuar? [s/N] "
read -r confirm
case "$confirm" in
  s|S|si|SI|Sí|sí) ;;
  *) echo "Instalación cancelada."; exit 0 ;;
esac

exec sh "$ROOT/scripts/install-pixel.sh"
