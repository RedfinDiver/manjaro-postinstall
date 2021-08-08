#!/bin/bash

# Run this script or its commands after a clean manjaro install
# Use the dummy user "test" for the initial install

sudo pacman -Syu --noconfirm

# groups and user
# we have to create the nfs group and the user with different
# primary gid and uid because of nfs on the synology nas
sudo groupadd --gid 100 nfs
sudo useradd -u 1028 -g nfs -c 'Markus Moser' -G wheel \
-m -p '$6$kjhbjhgjhd8$BMGCfP2rKyJucSh3TiWMkg/S0ZoA7FRGP19j2y2LotNNUmU2EuLF74t/qaS69wf0Xha7PrjdLqbz1mnuY/irW1' markus