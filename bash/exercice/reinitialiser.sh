#!/bin/bash
# Remet le donjon dans son état initial.

ICI="$(cd "$(dirname "$0")" && pwd)"
TRAPPE="$ICI/donjon/hall/.trappe"

rm -rf "$TRAPPE/pont" "$TRAPPE/crypte"

echo "Le donjon a été réinitialisé."
echo "Pour recommencer : cd donjon && cat parchemin"
