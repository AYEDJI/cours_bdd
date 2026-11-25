#!/bin/bash
# Salle 5 : le gardien de la bibliothèque (echo, export, unset)

ICI="$(cd "$(dirname "$0")" && pwd)"
MARQUE="$ICI/.gardien_satisfait"

trouver_coulisses() {
    local d="$ICI"
    while [ "$d" != "/" ] && [ -n "$d" ]; do
        if [ -d "$d/.coulisses" ]; then echo "$d/.coulisses"; return; fi
        d="$(dirname "$d")"
    done
}

echo "Le gardien lève les yeux de son livre..."
echo

# Étape 2 : le sortilège a déjà été lancé, il faut maintenant le dissiper
if [ -f "$MARQUE" ]; then
    if [ -n "${SORTILEGE+x}" ]; then
        echo "  \"La lumière brille toujours ($SORTILEGE) ! Elle m'éblouit."
        echo "   Fais disparaître la variable avec unset, puis reviens me voir.\""
        echo
        echo "  Indice : unset SORTILEGE"
        exit 1
    fi

    if [ -d "$ICI/scriptorium" ]; then
        echo "  \"Le scriptorium est déjà ouvert : cd scriptorium\""
        exit 0
    fi

    COULISSES="$(trouver_coulisses)"
    cp -r "$COULISSES/scriptorium" "$ICI/scriptorium"
    echo "  \"Parfait. Tu sais créer, lire et supprimer une variable."
    echo "   Je t'ouvre le passage vers le scriptorium.\""
    echo
    echo "    cd scriptorium"
    exit 0
fi

# Étape 1 : lancer le sortilège
if [ -z "${SORTILEGE+x}" ]; then
    echo "  \"Je ne sens aucun sortilège... La variable SORTILEGE n'existe pas"
    echo "   pour moi. L'as-tu bien créée AVEC export ?\""
    echo
    echo "  Indice : export SORTILEGE=lumiere"
    exit 1
fi

if [ "$SORTILEGE" != "lumiere" ]; then
    echo "  \"Ton sortilège vaut '$SORTILEGE'... ce n'est pas le bon !"
    echo "   Il me faut la lumiere.\""
    exit 1
fi

touch "$MARQUE"
echo "  \"Ah ! La lumière ! Je vois enfin clair.\""
echo
echo "  \"Mais un bon sorcier sait aussi effacer ses traces."
echo "   Supprime ta variable SORTILEGE, puis relance-moi.\""
echo
echo "  Indice : unset NOM_VARIABLE, puis vérifie avec echo \$SORTILEGE"
