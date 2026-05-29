#!/bin/bash

set -e

echo "=== Installation de Neovim + config ==="

# --- Dépendances ---
echo ">>> Installation des dépendances..."
sudo apt update -y
sudo apt install -y git curl nodejs npm

# --- Neovim 0.11 ---
echo ">>> Téléchargement de Neovim 0.11..."
curl -L -o /tmp/nvim-linux-x86_64.tar.gz \
  https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz

echo ">>> Installation de Neovim..."
tar -xzf /tmp/nvim-linux-x86_64.tar.gz -C /tmp/
sudo rm -rf /opt/nvim
sudo mv /tmp/nvim-linux-x86_64 /opt/nvim

# --- PATH ---
echo ">>> Ajout de Neovim au PATH..."
if ! grep -q "/opt/nvim/bin" ~/.bashrc; then
  echo 'export PATH="$PATH:/opt/nvim/bin"' >> ~/.bashrc
fi

export PATH="$PATH:/opt/nvim/bin"

# --- Config Neovim ---
echo ">>> Clonage de la config Neovim..."
NVIM_CONFIG="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG" ]; then
  echo ">>> Dossier existant détecté — sauvegarde dans ~/.config/nvim.bak"
  mv "$NVIM_CONFIG" "$HOME/.config/nvim.bak"
fi

git clone https://github.com/Dr00pyd00/NeoVim-Setup.git "$NVIM_CONFIG"

# --- Installation des plugins ---
echo ">>> Installation des plugins lazy.nvim..."
nvim --headless "+Lazy! sync" +qa

echo ""
echo "=== Installation terminée ! ==="
echo "Lance 'source ~/.bashrc' puis 'nvim' pour démarrer."





