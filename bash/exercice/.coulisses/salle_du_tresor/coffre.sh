#!/bin/bash
# Salle 7 : le coffre (shebang, chmod +x, ./script.sh)

ICI="$(cd "$(dirname "$0")" && pwd)"
SCRIPT="$ICI/ouvrir.sh"

echo "Le mécanisme du coffre se met à cliqueter..."
echo

if [ ! -f "$SCRIPT" ]; then
    echo "  Le coffre attend ta formule, mais ouvrir.sh n'existe pas."
    echo "  Crée-le avec : vim ouvrir.sh"
    exit 1
fi

premiere=$(head -n 1 "$SCRIPT" | tr -d '\r')
if [ "$premiere" != "#!/bin/bash" ]; then
    echo "  La première ligne de ouvrir.sh doit être le shebang : #!/bin/bash"
    echo "  (actuellement : \"$premiere\")"
    exit 1
fi

if [ ! -x "$SCRIPT" ]; then
    echo "  ouvrir.sh n'est pas exécutable. Vérifie avec ls -l,"
    echo "  puis : chmod +x ouvrir.sh"
    exit 1
fi

formule=$(cd "$ICI" && ./ouvrir.sh 2>/dev/null | tr -d '\r')
if ! echo "$formule" | grep -qi "sesame, ouvre-toi"; then
    echo "  Ton script dit : \"$formule\""
    echo "  Ce n'est pas la bonne formule. Il doit afficher : Sesame, ouvre-toi"
    exit 1
fi

cat <<'FIN'
  "Sesame, ouvre-toi !"

  Le couvercle se soulève lentement...

            _______________
           /\              \
          /  \   * * * *    \
         /    \______________\
         \    / $  $  $  $   /
          \  /  $  $  $  $  /
           \/______________/

  =====================================================
     FÉLICITATIONS ! TU AS VAINCU LE DONJON DU SHELL !
  =====================================================

  Tu sais maintenant :
    - te déplacer et explorer   : cd, ls, ls -a, ls -l, pwd, cat
    - construire                : mkdir, mkdir -p, touch
    - détruire (prudemment)     : rm, rm *.log, rm -r
    - manier les variables      : echo $VAR, export, unset
    - éditer avec vim           : i, o, dd, :%s, :wq
    - écrire tes scripts        : #!/bin/bash, chmod +x, ./script.sh

  Pour rejouer : retourne dans bash/exercice et lance
      bash reinitialiser.sh
FIN
