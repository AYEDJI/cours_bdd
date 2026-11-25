# Le Donjon du Shell – mini-jeu Bash

Un petit jeu d'aventure qui se joue **uniquement dans le terminal**.
Chaque dossier est une salle, chaque fichier `parchemin` contient les instructions de la salle.
Pour avancer, tu devras utiliser les commandes vues dans le cours :

| Salle | Notions travaillées | Chapitre du cours |
|-------|---------------------|-------------------|
| 1. L'entrée du donjon | `cat`, `ls`, `cd`, `cd ..` | [intro.md](../intro.md) |
| 2. Le hall | `pwd`, `ls -l`, `ls -a` (fichiers cachés) | [intro.md](../intro.md) |
| 3. La trappe | `mkdir`, `mkdir -p`, `touch` | [intro.md](../intro.md) |
| 4. La crypte | `rm`, `rm *.log`, `rm -r` | [intro.md](../intro.md) |
| 5. La bibliothèque | `echo $VAR`, `export`, `unset` | [variable_env.md](../variable_env.md) |
| 6. Le scriptorium | `vim` : navigation, `dd`, `o`, `:%s`, `:wq` | [vim.md](../vim.md) |
| 7. La salle du trésor | shebang, `chmod +x`, `./script.sh` | [xecute_bash_script.md](../xecute_bash_script.md) |

---

## Prérequis

Un terminal Bash : Linux, WSL, macOS ou GitHub Codespaces (voir [intro.md](../intro.md), partie 0).
L'éditeur `vim` doit être installé (il l'est presque toujours).

## Commencer à jouer

Depuis le dossier `bash/exercice/` :

```bash
cd donjon
cat parchemin
```

Ensuite, laisse-toi guider par les parchemins.

## Règles

- On lit un parchemin avec `cat parchemin`.
- Certaines salles n'existent pas encore : elles apparaissent quand tu réussis l'épreuve de la salle précédente.
- Les épreuves se valident en lançant le script indiqué dans le parchemin (par exemple `bash verifier.sh`).
- Le dossier caché `.coulisses/` contient les décors du jeu : **n'y va pas**, ce serait de la triche !

## Recommencer une partie

Depuis le dossier `bash/exercice/` :

```bash
bash reinitialiser.sh
```

Cette commande supprime tout ce que tu as créé ou débloqué et remet le donjon à zéro.
