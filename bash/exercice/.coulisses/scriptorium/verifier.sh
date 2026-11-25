#!/bin/bash
# Vérification de la salle 6 : correction du grimoire avec vim

ICI="$(cd "$(dirname "$0")" && pwd)"
GRIMOIRE="$ICI/grimoire.txt"

trouver_coulisses() {
    local d="$ICI"
    while [ "$d" != "/" ] && [ -n "$d" ]; do
        if [ -d "$d/.coulisses" ]; then echo "$d/.coulisses"; return; fi
        d="$(dirname "$d")"
    done
}

if [ "$1" = "--reparer" ]; then
    COULISSES="$(trouver_coulisses)"
    cp "$COULISSES/scriptorium/grimoire.txt" "$GRIMOIRE"
    echo "Le grimoire a retrouvé son état d'origine. Rouvre-le : vim grimoire.txt"
    exit 0
fi

if [ ! -f "$GRIMOIRE" ]; then
    echo "Le grimoire a disparu ! Répare-le avec : bash verifier.sh --reparer"
    exit 1
fi

erreurs=0
echo "Tu lis le grimoire à voix haute..."
echo

if grep -qi "nuit" "$GRIMOIRE"; then
    echo "  [ÉCHEC] Il reste le mot \"nuit\" : utilise :%s/nuit/jour/g (n'oublie pas le g !)"
    erreurs=$((erreurs + 1))
elif [ "$(grep -o "jour" "$GRIMOIRE" | wc -l)" -lt 4 ]; then
    echo "  [ÉCHEC] Il devrait y avoir 4 fois le mot \"jour\"."
    erreurs=$((erreurs + 1))
else
    echo "  [OK]    La nuit a laissé place au jour."
fi

if grep -q "MALEDICTION" "$GRIMOIRE"; then
    echo "  [ÉCHEC] La ligne MALEDICTION est toujours là : place-toi dessus et tape dd"
    erreurs=$((erreurs + 1))
else
    echo "  [OK]    La malédiction est levée."
fi

derniere=$(grep -v '^[[:space:]]*$' "$GRIMOIRE" | tail -n 1 | tr -d '\r' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
if echo "$derniere" | grep -qiE '^je ma(i|î)trise vim\.?$'; then
    echo "  [OK]    La dernière ligne proclame ta maîtrise de vim."
else
    echo "  [ÉCHEC] La dernière ligne doit être \"Je maitrise vim\" (actuellement : \"$derniere\")"
    erreurs=$((erreurs + 1))
fi

if [ "$(head -n 1 "$GRIMOIRE" | tr -d '\r')" != "Grimoire du scriptorium" ]; then
    echo "  [ÉCHEC] Le titre (1re ligne) a été abîmé. Tu peux réparer avec : bash verifier.sh --reparer"
    erreurs=$((erreurs + 1))
fi

echo
if [ "$erreurs" -gt 0 ]; then
    echo "Le grimoire résiste encore. Rouvre-le avec vim grimoire.txt"
    exit 1
fi

if [ -d "$ICI/salle_du_tresor" ]; then
    echo "Le grimoire est corrigé. La salle du trésor est déjà ouverte : cd salle_du_tresor"
    exit 0
fi

COULISSES="$(trouver_coulisses)"
cp -r "$COULISSES/salle_du_tresor" "$ICI/salle_du_tresor"
chmod -x "$ICI/salle_du_tresor/coffre.sh" 2>/dev/null

echo "Le soleil inonde le scriptorium ! Une bibliothèque pivote"
echo "et révèle une dernière porte : la salle du trésor."
echo
echo "    cd salle_du_tresor"
