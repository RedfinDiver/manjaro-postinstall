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
sudo mkdir /usr/share/java/apache-ant
sudo cp ./files/ant/* /usr/share/java/apache-ant/
sudo archlinux-java set java-11-openjdk

# docker configuration
sudo usermod -aG docker markus
sudo systemctl start docker
sudo systemctl enable docker

# cups configuration
sudo systemctl start cups
sudo systemctl enable cups

# hosts file configuration
sudo cp -f ./files/system/hosts /etc/hosts

# fish and oh-my-fish configuration
sudo chsh -s /usr/bin/fish markus
rm -f ~/.config/fish/config.fish
ln -s ~/Projekte/manjaro-postinstall/files/fish/config.fish /home/markus/.config/fish/config.fish
rm -f ~/.config/fish/functions/fish_greeting.fish
ln -s ~/Projekte/manjaro-postinstall/files/fish/fish_greeting.fish /home/markus/.config/fish/functions/fish_greeting.fish

# install fonts
mkdir ~/.local/share/fonts
cp ~/Projekte/manjaro-postinstall/files/fonts/* ~/.local/share/fonts/
fc-cache -f -v

# user picture
sudo cp ~/Projekte/manjaro-postinstall/files/gnome/markus.jpg /var/lib/AccountsService/icons/markus
sudo cp ~/Projekte/manjaro-postinstall/files/gnome/account /var/lib/AccountsService/users/markus

# gsettings, dconf watch / is your friend!

# keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal öffnen'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Primary><Alt>t'"

# nautilus configuration
gsettings set org.gnome.nautilus.list-view use-tree-view "false"
gsettings set org.gnome.nautilus.preferences default-folder-viewer "list-view"
gsettings set org.gnome.nautilus.preferences click-policy "double"
gsettings set org.gnome.nautilus.list-view default-zoom-level "small"

# theme configuration
mkdir ~/Projekte
git clone https://github.com/vinceliuice/McMojave-circle.git ~/Projekte/McMojave-circle
git clone https://github.com/vinceliuice/Mojave-gtk-theme.git ~/Projekte/McMojave-gtk-theme
sudo ~/Projekte/McMojave-gtk-theme/install.sh -c dark -o solid -i manjaro -g
sudo ~/Projekte/McMojave-circle/install.sh -grey
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.desktop.interface gtk-theme "Mojave-dark-solid"
gsettings set org.gnome.desktop.interface icon-theme "McMojave-circle-grey-dark"
gsettings set org.gnome.shell.extensions.user-theme name "Mojave-dark-solid"
sudo cp ./files/gnome/wallpaper.jpg /usr/share/backgrounds/markus-wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/markus-wallpaper.jpg"
gsettings set org.gnome.desktop.interface font-name "Noto Sans Regular 10"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop', 'chromium.desktop', 'bitwarden.desktop', 'org.gnome.tweaks.desktop', 'webserver.desktop', 'org.gnome.Extensions.desktop', 'visual-studio-code.desktop']"

# cleaning up
sudo userdel -r test