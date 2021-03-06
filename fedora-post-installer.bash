#!/usr/bin/env bash

set -euxo pipefail

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


dnf install -y stow

sudo -u "$USERNAME" bash -c 'mkdir -p ~/.local/bin/'
sudo -u "$USERNAME" bash -c 'rm -f ~/.bash{rc,_profile}'
sudo -u "$USERNAME" bash -c 'stow -S bash git nvim starship tealdeer bin task kitty'

sudo -u "$USERNAME" bash -c 'chmod +x ~/.configuration/bin/.local/bin/*'

sudo -u "$USERNAME" bash <<EOF
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
  mkdir -p ~/.local/bin/
  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=/home/$USERNAME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
  stow kitty
EOF


sudo -u "$USERNAME" bash <<EOF
  mkdir -p ~/.local/share/fonts
  pushd /tmp
  curl -LO https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip
  unzip JetBrainsMono-2.242.zip
  cp /tmp/fonts/ttf/* ~/.local/share/fonts
  fc-cache -f -v
  popd
EOF


dnf install -y neovim
sudo -u "$USERNAME" bash -c 'git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim'


# https://fedoraproject.org/wiki/SIGs/Sway
dnf install -y grim kanshi mako rofi slurp sway swaybg swayidle swaylock waybar wlroots xdg-desktop-portal-wlr

dnf install -y wl-clipboard nnn htop


sudo -u "$USERNAME" bash -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -v -y --no-modify-path'

dnf install -y starship ripgrep fd-find exa tealdeer fzf task ShellCheck

# tldr --update


# install `aspell` and Polish dictionary
dnf install -y aspell
pushd /tmp
curl -O "https://sjp.pl$(curl --silent https://sjp.pl/slownik/en/ | grep -E aspell6 | cut -d \" -f 2)"
tar xvjf sjp-aspell6*.tar.bz2
cd aspell6*
./configure
make install
popd


dnf install -y vlc gimp inkscape


git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

dnf install -y openssl-devel zlib-devel
asdf plugin add ruby
asdf install ruby latest:2
asdf install ruby latest:3
echo ruby $(asdf latest ruby 2) >> /home/$USERNAME/.tool-versions

mv -v ~/.asdf /home/$USERNAME/.asdf
chown -R $USERNAME:$USERNAME /home/$USERNAME/.asdf

dnf install -y gcc-c++
# :TSInstall ruby
# :LspInstall solargraph rust_analyzer
