#!/bin/bash

# Run the commands of this file after a clean manjaro install
# Use the dummy user "test" for the initial installation of manjaro

# Update everything
sudo pacman -Syu --noconfirm

# Groups and user
# I have to create my user with different primary gid and uid because of nfs on the synology nas
sudo groupadd --gid 100 nfs
sudo useradd -u 1028 -g nfs -c 'Markus Moser' -G wheel -m -p '$6$kjhbjhgjhd8$BMGCfP2rKyJucSh3TiWMkg/S0ZoA7FRGP19j2y2LotNNUmU2EuLF74t/qaS69wf0Xha7PrjdLqbz1mnuY/irW1' markus

# After creating the user reboot and log in as markus

# Logged in as markus run the following commands
mkdir ~/Projekte
cd Projekte
git clone https://github.com/redfindiver/manjaro-postinstall.git
