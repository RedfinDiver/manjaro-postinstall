#!/bin/bash

# Run this script only after the 02_install_apps.sh script
# Make sure to be logged in as user "markus" when running current script
# Clone the repo to ~/Projekte first to make the symlinks work!

sudo pacman -Syu --noconfirm

# NAS mounts
sudo mkdir -p /NAS/{markus,docker,ebooks,share}
sudo cp ./files/systemd/* /etc/systemd/system/

sudo systemctl start NetworkManager-wait-online.service
sudo systemctl enable NetworkManager-wait-online.service

sudo systemctl start NAS-markus.automount
sudo systemctl enable NAS-markus.automount

sudo systemctl start NAS-docker.automount
sudo systemctl enable NAS-docker.automount

sudo systemctl start NAS-ebooks.automount
sudo systemctl enable NAS-ebooks.automount

sudo systemctl start NAS-share.automount
sudo systemctl enable NAS-share.automount

# git configuration
git config --global user.name "Redfindiver"
git config --global user.email "redfindiver@gmail.com"

# ant configuration
sudo cp ./files/ant/* /usr/share/java/ant/

# docker configuration
sudo usermod -aG docker markus
sudo systemctl start docker
sudo systemctl enable docker

# cups configuration
sudo systemctl start cups
sudo systemctl enable cups

# hosts file configuration
sudo cp -f ./files/system/hosts /etc/hosts

# gsettings, dconf watch / is your friend!

# keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal öffnen'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Primary><Alt>t'"

# cleaning up
sudo userdel -r test
