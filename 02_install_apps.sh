#!/bin/bash

# Run this script only after the 01_create_user.sh script
# Make sure to be logged in as user "markus" when running current script
# Clone the repo to ~/Projekte first

sudo pacman -Syu --noconfirm

# Official repository installs
sudo pacman -S \
firefox \
chromium \
inkscape \
gimp gimp-help-de \
keepassxc \
handbrake \
fish \
libreoffice-still libreoffice-still-de \
hplip cups \
jre11-openjdk-headless jre11-openjdk jdk11-openjdk openjdk11-src \
ant \
docker docker-compose python-pip \
synology-drive-client \
gtk-engine-murrine gtk-engines sassc optipng --noconfirm --needed

# pipenv install
yes | sudo pip install pipenv

# Flatpak installs
sudo pacman -S flatpak --noconfirm
flatpak install flathub us.zoom.Zoom --noninteractive

# AUR installs
pamac build \
gimp-plugin-saveforweb \
bitwarden-bin \
visual-studio-code-bin --no-confirm

# oh-my-fish install
curl -L https://get.oh-my.fish | fish
