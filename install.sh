#!/usr/bin/env bash 
# env -> programme qui recherche la commande dans les PATH (plus portable)

set -e   # stop script if error
sudo -v 

DOTFILES_DIR="$HOME/dotfiles"

echo ">>> Udpating Dev Setup !!! >>>"
sudo apt update -y && sudo apt upgrade -y 

echo ">>> Installing base dev tools..."
sudo apt install -y \
  build-essential \
  curl wget \
  git \
  tree \
  htop \
  unzip zip \
  ca-certificates \
  software-properties-common \
  tmux \
  vim-gtk3 \
  xclip \
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


echo ">>> Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz


echo ">>> Installing Node.js..."
sudo apt install -y nodejs npm


# ici il faut une fonction qui verifie que les configs ou links existent pas deja, si c'estle cas , ajoute ".bak" a la fin pour pas les ecraser.
make_link() {
    local src=$1
    local dst=$2

    # on teste si le fichier ou link existe deja:
    if [ -e "$dst" ] || [ -L "$dst" ]; then 
        mv "$dst" "$dst.bak"
        echo "Backed up $dst --> $dst.bak !!"
    fi

    # creation du link
    ln -s "$src" "$dst"
    echo "Linked $src --> $dst !! "
}

# on appel 3 fois pour le moment:
echo ">>> Creating symlinks..."
make_link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
make_link "$DOTFILES_DIR/vim/vimrc"      "$HOME/.vimrc"
make_link "$DOTFILES_DIR/nvim"           "$HOME/.config/nvim"


echo ">>> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>> Installing vim plugins..."
vim +PlugInstall +qall


echo "YAY Setup Completed !!!"




