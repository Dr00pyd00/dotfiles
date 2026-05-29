# Neovim — Fiche de commandes

## Modes

| Touche | Action |
|--------|--------|
| `i` | Passer en mode insertion (avant le curseur) |
| `a` | Passer en mode insertion (après le curseur) |
| `o` | Nouvelle ligne en dessous + mode insertion |
| `O` | Nouvelle ligne au dessus + mode insertion |
| `Escape` | Retour en mode normal |
| `v` | Mode visuel (sélection caractère) |
| `V` | Mode visuel ligne |
| `:` | Mode commande |

---

## Navigation (mode normal)

| Touche | Action |
|--------|--------|
| `h j k l` | Gauche / Bas / Haut / Droite |
| `gg` | Aller au début du fichier |
| `G` | Aller à la fin du fichier |
| `{numéro}G` | Aller à la ligne numéro (ex: `42G`) |
| `w` | Mot suivant |
| `b` | Mot précédent |
| `0` | Début de la ligne |
| `$` | Fin de la ligne |
| `Ctrl+d` | Descendre d'une demi-page |
| `Ctrl+u` | Monter d'une demi-page |

---

## Édition (mode normal)

| Touche | Action |
|--------|--------|
| `dd` | Supprimer la ligne |
| `yy` | Copier la ligne |
| `p` | Coller en dessous |
| `P` | Coller au dessus |
| `u` | Annuler (undo) |
| `Ctrl+r` | Rétablir (redo) |
| `ciw` | Supprimer le mot sous le curseur + insertion |
| `cc` | Supprimer la ligne + insertion |
| `ggVGd` | Sélectionner tout + supprimer |
| `>` | Indenter la sélection |
| `<` | Désindenter la sélection |

---

## Fichiers et buffers

| Commande | Action |
|----------|--------|
| `:w` | Sauvegarder |
| `:q` | Quitter |
| `:wq` | Sauvegarder et quitter |
| `:qa!` | Quitter tout sans sauvegarder |
| `:e chemin/fichier` | Ouvrir un fichier |
| `:ls` | Lister les buffers ouverts |
| `:bn` | Buffer suivant |
| `:bp` | Buffer précédent |

---

## Splits (fenêtres)

| Commande / Touche | Action |
|-------------------|--------|
| `:vsp` | Split vertical |
| `:sp` | Split horizontal |
| `Ctrl+w h/j/k/l` | Naviguer entre les splits |
| `Ctrl+w q` | Fermer le split actif |

---

## Recherche

| Commande | Action |
|----------|--------|
| `/mot` | Chercher "mot" vers le bas |
| `?mot` | Chercher "mot" vers le haut |
| `n` | Occurrence suivante |
| `N` | Occurrence précédente |
| `:%s/ancien/nouveau/g` | Remplacer dans tout le fichier |

---

## Lazy.nvim (gestionnaire de plugins)

| Commande | Action |
|----------|--------|
| `:Lazy` | Ouvrir l'interface Lazy |
| `:Lazy sync` | Installer / mettre à jour / nettoyer |
| `:Lazy update` | Mettre à jour les plugins |
| `:Lazy clean` | Supprimer les plugins inutilisés |
| `q` | Fermer l'interface Lazy |

---

## Telescope (recherche)

| Raccourci | Action |
|-----------|--------|
| `Espace ff` | Chercher un fichier par nom |
| `Espace fg` | Chercher dans le contenu des fichiers |
| `Espace fb` | Lister les buffers ouverts |

**Dans la fenêtre Telescope :**

| Touche | Action |
|--------|--------|
| Taper du texte | Filtrer les résultats |
| `Entrée` | Ouvrir le fichier |
| `Ctrl+v` | Ouvrir dans un split vertical |
| `Ctrl+x` | Ouvrir dans un split horizontal |
| `Escape` | Fermer Telescope |

---

## Neo-tree (explorateur de fichiers)

| Raccourci | Action |
|-----------|--------|
| `Espace e` | Ouvrir / fermer l'explorateur |

**Dans Neo-tree :**

| Touche | Action |
|--------|--------|
| `h j k l` | Naviguer |
| `Entrée` | Ouvrir le fichier |
| `s` | Ouvrir dans un split vertical |
| `S` | Ouvrir dans un split horizontal |
| `a` | Créer un fichier |
| `d` | Supprimer |
| `r` | Renommer |
| `q` | Fermer Neo-tree |

---

## LSP (Language Server Protocol)

| Raccourci / Commande | Action |
|----------------------|--------|
| `gd` | Aller à la définition |
| `gr` | Voir les références |
| `K` | Afficher la documentation |
| `Ctrl+Space` | Forcer l'autocomplétion |
| `:checkhealth lsp` | Vérifier l'état du LSP |
| `:Mason` | Ouvrir le gestionnaire de serveurs LSP |

**Menu d'autocomplétion (nvim-cmp) :**

| Touche | Action |
|--------|--------|
| `Tab` | Élément suivant |
| `Shift+Tab` | Élément précédent |
| `Entrée` | Confirmer la sélection |
| `Ctrl+e` | Fermer le menu |
| `Ctrl+Space` | Ouvrir le menu |

---

## Diagnostics LSP

| Lettre | Signification |
|--------|---------------|
| `E` | Error — erreur sérieuse |
| `W` | Warning — avertissement |
| `H` | Hint — suggestion mineure |
| `I` | Info — information |

---

## Structure de la config

```
~/.config/nvim/
├── init.lua                  ← point d'entrée
├── lsp/
│   └── pyright.lua           ← config serveur LSP Python
└── lua/
├── core/
│   ├── options.lua       ← options vim
│   └── lazy.lua          ← bootstrap lazy.nvim
└── plugins/
    ├── catppuccin.lua    ← thème
    ├── telescope.lua     ← recherche de fichiers
    ├── neo-tree.lua      ← explorateur de fichiers
    ├── lsp.lua           ← Mason + serveurs LSP
    └── cmp.lua           ← autocomplétion
```

**Pour ajouter un plugin :**
1. Créer un fichier dans `lua/plugins/nom-du-plugin.lua`
2. Coller le bloc `return { ... }` depuis la page GitHub du plugin
3. Relancer Neovim → lazy installe automatiquement



