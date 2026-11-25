#!/bin/bash
# Vérification de la salle 3 : construction du pont (mkdir, mkdir -p, touch)

ICI="$(cd "$(dirname "$0")" && pwd)"

trouver_coulisses() {
    local d="$ICI"
    while [ "$d" != "/" ] && [ -n "$d" ]; do
        if [ -d "$d/.coulisses" ]; then echo "$d/.coulisses"; return; fi
        d="$(dirname "$d")"
    done
}

erreurs=0
verifier_dossier() {
    if [ -d "$ICI/$1" ]; then echo "  [OK]    dossier $1"; else echo "  [MANQUE] dossier $1"; erreurs=$((erreurs + 1)); fi
}
verifier_fichier() {
    if [ -f "$ICI/$1" ]; then echo "  [OK]    fichier $1"; else echo "  [MANQUE] fichier $1"; erreurs=$((erreurs + 1)); fi
}

echo "Tu poses le pied sur ton pont..."
echo
verifier_dossier "pont"
verifier_fichier "pont/planche1"
verifier_fichier "pont/planche2"
verifier_dossier "pont/piliers"
verifier_dossier "pont/piliers/gauche"
verifier_dossier "pont/piliers/droit"
echo

if [ "$erreurs" -gt 0 ]; then
    echo "CRAC ! Le pont s'effondre ($erreurs élément(s) manquant(s))."
    echo "Relis le parchemin (cat parchemin), complète ton pont et réessaie."
    exit 1
fi

if [ -d "$ICI/crypte" ]; then
    echo "Le pont est solide. La crypte est déjà ouverte : cd crypte"
    exit 0
fi

COULISSES="$(trouver_coulisses)"
cp -r "$COULISSES/crypte" "$ICI/crypte"

echo "Le pont tient bon ! Tu traverses le gouffre."
echo "Une lourde porte s'ouvre sur une nouvelle salle : la crypte."
echo
echo "    ls            pour la voir"
echo "    cd crypte     pour y entrer"
