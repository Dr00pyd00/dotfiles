
#!/usr/bin/env bash
# ============================================================
#  Personal Dev Setup — dotfiles installer
#
#  Usage:
#    ./install.sh              -> mode editors (par defaut)
#    ./install.sh --editors    -> vim + nvim + node + symlinks
#    ./install.sh --full       -> editors + outils dev/debug/reseau
#    ./install.sh --help
# ============================================================

set -euo pipefail

# ------------------------------------------------------------
# 0. Emplacement reel du repo (plus de chemin code en dur)
# ------------------------------------------------------------
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODE="editors"

while [ $# -gt 0 ]; do
  case "$1" in
    --editors) MODE="editors" ;;
    --full)    MODE="full" ;;
    -h|--help)
      echo "Usage: $0 [--editors|--full]"
      echo "  --editors  vim + nvim + node + symlinks (defaut, leger)"
      echo "  --full     editors + tous les outils dev/debug/reseau"
      exit 0
      ;;
    *)
      echo "Option inconnue: $1  (voir --help)" >&2
      exit 1
      ;;
  esac
  shift
done

echo ">>> Mode: $MODE"
echo ">>> Repo: $DOTFILES_DIR"

# ------------------------------------------------------------
# 1. sudo + keep-alive (evite l'expiration pendant un long apt)
# ------------------------------------------------------------
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT

# ------------------------------------------------------------
# 2. Paquets apt
# ------------------------------------------------------------
echo ">>> apt update..."
sudo apt update -y

echo ">>> Installing editor essentials..."
sudo apt install -y \
  build-essential \
  curl wget \
  git \
  unzip zip \
  ca-certificates \
  vim-gtk3 \
  xclip \
  tmux

if [ "$MODE" = "full" ]; then
  echo ">>> apt upgrade..."
  sudo apt upgrade -y

  echo ">>> Installing extra dev tools..."
  sudo apt install -y \
    tree \
    htop \
    software-properties-common \
    python3 \
    python3-pip \
    python3-venv

  echo ">>> Installing debug & network tools..."
  sudo apt install -y \
    strace \
    ltrace \
    gdb \
    lsof \
    net-tools \
    iproute2 \
    netcat-openbsd \
    tcpdump
fi

# ------------------------------------------------------------
# 3. Neovim (tarball dans /tmp, jamais dans le repo)
# ------------------------------------------------------------
echo ">>> Installing Neovim..."

case "$(uname -m)" in
  x86_64)  NVIM_ARCH="linux-x86_64" ;;
  aarch64) NVIM_ARCH="linux-arm64" ;;
  *) echo "Architecture non supportee: $(uname -m)" >&2; exit 1 ;;
esac

NVIM_TMP="$(mktemp -d)"
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true; rm -rf "$NVIM_TMP"' EXIT

curl -fL -o "$NVIM_TMP/nvim.tar.gz" \
  "https://github.com/neovim/neovim/releases/latest/download/nvim-${NVIM_ARCH}.tar.gz"

sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
sudo tar -C /opt -xzf "$NVIM_TMP/nvim.tar.gz"
sudo ln -sfn "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

echo ">>> Neovim: $(/usr/local/bin/nvim --version | head -1)"

# ------------------------------------------------------------
# 4. Node.js via nvm (evite les conflits avec les paquets apt)
# ------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

node_ok() {
  command -v node >/dev/null 2>&1 || return 1
  local major
  major="$(node -v | sed 's/^v//' | cut -d. -f1)"
  [ "$major" -ge 18 ]
}

# charge nvm s'il est deja installe mais pas dans ce shell
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
fi

if node_ok; then
  echo ">>> Node deja present: $(node -v)"
else
  echo ">>> Installing nvm + Node LTS..."
  # nvm refuse de s'installer si NVM_DIR est defini mais pointe dans le vide
  mkdir -p "$NVM_DIR"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
  echo ">>> Node installe: $(node -v)"
fi

# ------------------------------------------------------------
# 5. tree-sitter CLI (necessaire pour :TSInstall)
# ------------------------------------------------------------
if tree-sitter --version >/dev/null 2>&1; then
  echo ">>> tree-sitter CLI deja present: $(tree-sitter --version)"
else
  echo ">>> Installing tree-sitter CLI..."
  npm install -g tree-sitter-cli >/dev/null 2>&1 || true

  # npm recent bloque les scripts d'install par defaut, or c'est ce script
  # qui telecharge le vrai binaire -> on reessaie en l'autorisant.
  if ! tree-sitter --version >/dev/null 2>&1; then
    npm install -g --allow-scripts=tree-sitter-cli tree-sitter-cli >/dev/null 2>&1 || true
  fi

  if tree-sitter --version >/dev/null 2>&1; then
    echo ">>> tree-sitter CLI installe: $(tree-sitter --version)"
  else
    echo "!! tree-sitter CLI indisponible — ':TSInstall' echouera."
    echo "!! essaie a la main: npm install -g --allow-scripts=tree-sitter-cli tree-sitter-cli"
  fi
fi

# ------------------------------------------------------------
# 6. Symlinks
# ------------------------------------------------------------
make_link() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    echo "!! source introuvable, ignore: $src" >&2
    return 0
  fi

  # cree le dossier parent si besoin (~/.config par exemple)
  mkdir -p "$(dirname "$dst")"

  # deja le bon lien -> rien a faire
  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
    echo "= deja lie: $dst"
    return 0
  fi

  # backup horodate -> on n'ecrase jamais un ancien .bak
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local backup
    backup="$dst.bak.$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$backup"
    echo "~ backup: $dst -> $backup"
  fi

  ln -s "$src" "$dst"
  echo "+ link: $dst -> $src"
}

echo ">>> Creating symlinks..."
make_link "$DOTFILES_DIR/vim/vimrc"  "$HOME/.vimrc"
make_link "$DOTFILES_DIR/nvim"       "$HOME/.config/nvim"
make_link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# ------------------------------------------------------------
# 7. vim-plug + plugins vim
# ------------------------------------------------------------
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo ">>> Installing vim-plug..."
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo ">>> Installing vim plugins..."
vim +PlugInstall +qall </dev/null >/dev/null 2>&1 || echo "!! PlugInstall a echoue, lance ':PlugInstall' dans vim"

# ------------------------------------------------------------
# 8. Plugins Neovim (lazy) + serveurs LSP (mason)
# ------------------------------------------------------------
echo ">>> Syncing Neovim plugins (lazy.nvim)..."
nvim --headless "+Lazy! sync" +qa </dev/null 2>&1 | tail -3 || echo "!! Lazy sync incomplet, relance nvim manuellement"

echo ">>> Installing LSP servers (mason)..."
nvim --headless "+MasonInstall basedpyright emmet-language-server" +qa </dev/null >/dev/null 2>&1 \
  || echo "!! MasonInstall a echoue, lance ':Mason' dans nvim"

# ------------------------------------------------------------
echo ""
echo "=== Setup termine (mode: $MODE) ==="
echo "Ouvre un nouveau terminal (ou: source ~/.bashrc) pour charger Node."
