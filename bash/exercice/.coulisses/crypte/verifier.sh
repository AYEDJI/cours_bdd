#!/bin/bash
# Vérification de la salle 4 : nettoyage de la crypte (rm, rm *.log, rm -r)

ICI="$(cd "$(dirname "$0")" && pwd)"

trouver_coulisses() {
    local d="$ICI"
    while [ "$d" != "/" ] && [ -n "$d" ]; do
        if [ -d "$d/.coulisses" ]; then echo "$d/.coulisses"; return; fi
        d="$(dirname "$d")"
    done
}

if [ ! -f "$ICI/squelette.txt" ]; then
    echo "Tu as supprimé le squelette... Le fantôme de l'ancien aventurier"
    echo "est furieux ! Avec rm, rien ne revient jamais."
    echo
    echo "Pour cette fois, le fantôme te pardonne et remet le squelette."
    COULISSES="$(trouver_coulisses)"
    cp "$COULISSES/crypte/squelette.txt" "$ICI/squelette.txt"
    echo "Relance : bash verifier.sh"
    exit 1
fi

nb_araignees=$(ls "$ICI" | grep -c '^araignee.*\.log$')
if [ "$nb_araignees" -gt 0 ]; then
    echo "Il reste encore $nb_araignees araignée(s) ! Utilise le joker : rm *.log"
    exit 1
fi

if [ -e "$ICI/toile" ]; then
    echo "La toile bloque toujours le passage."
    echo "C'est un dossier non vide : rm -r toile"
    exit 1
fi

if [ -d "$ICI/bibliotheque" ]; then
    echo "La crypte est propre. La bibliothèque est déjà ouverte : cd bibliotheque"
    exit 0
fi

COULISSES="$(trouver_coulisses)"
cp -r "$COULISSES/bibliotheque" "$ICI/bibliotheque"

echo "La crypte est nettoyée ! Derrière la toile, un escalier"
echo "mène à une salle remplie de livres : la bibliothèque."
echo
echo "    cd bibliotheque"
