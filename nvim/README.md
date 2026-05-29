# NeoVim Setup

Ma configuration personnelle de Neovim, modulaire et versionnée.

## Stack

- **Neovim** 0.11
- **lazy.nvim** — gestionnaire de plugins
- **Catppuccin Mocha** — thème
- **Telescope** — recherche de fichiers
- **Neo-tree** — explorateur de fichiers
- **Pyright** — LSP Python (via Mason)
- **nvim-cmp** — autocomplétion

## Installation rapide

> Testé sur Ubuntu 24. Nécessite `curl` et `git`.

```bash
curl -sL https://raw.githubusercontent.com/Dr00pyd00/NeoVim-Setup/main/install.sh | bash
```

Puis recharge ton terminal :

```bash
source ~/.bashrc
```

Lance Neovim — les plugins s'installent automatiquement au premier démarrage :

```bash
nvim
```

## Installation manuelle

Clone le repo dans `~/.config/nvim` :

```bash
git clone git@github.com:Dr00pyd00/NeoVim-Setup.git ~/.config/nvim
```

Ajoute Neovim au PATH dans ton `~/.bashrc` :

```bash
echo 'export PATH="$PATH:/opt/nvim/bin"' >> ~/.bashrc
source ~/.bashrc
```

Lance Neovim — lazy.nvim installe tout au démarrage.

## Structure

```
~/.config/nvim/
├── init.lua                  ← point d'entrée
├── install.sh                ← script d'installation automatique
├── lsp/
│   └── pyright.lua           ← config LSP Python
└── lua/
    ├── core/
    │   ├── options.lua       ← options vim
    │   └── lazy.lua          ← bootstrap lazy.nvim
    └── plugins/
        ├── catppuccin.lua
        ├── telescope.lua
        ├── neo-tree.lua
        ├── lsp.lua
        └── cmp.lua
```

## Raccourcis principaux

| Raccourci | Action |
|-----------|--------|
| `Espace ff` | Chercher un fichier |
| `Espace fg` | Chercher dans les fichiers |
| `Espace fb` | Buffers ouverts |
| `Espace e` | Ouvrir / fermer l'explorateur |
| `Ctrl+Space` | Forcer l'autocomplétion |
| `Tab` | Élément suivant dans le menu |
| `Entrée` | Confirmer la sélection |

