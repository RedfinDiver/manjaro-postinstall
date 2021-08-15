#!/bin/bash

# Run this script only after the 01_create_user.sh script
# Make sure to be logged in as user "markus" when running current script
# Clone the repo to ~/Projekte first

sudo pacman -Syu --noconfirm

# install function for all packages
apps::install() {
    # read the apps list file
    while IFS= read -r line; do
    if [[ "${line}" =~ ^# || -z "${line}" ]]
    then
        continue;
    fi

    local app_data=(${line})
    local app_name="${app_data[0]}"
    
    if [ -z "${app_data[1]}" ]
    then
        app_src="manjaro"
    else
        app_src="${app_data[1]}"
    fi

    apps::install_helper "${app_name}" "${app_src}"

    done < "./apps.list"
}

# helper function
apps::install_helper() {
    local app="$1"
    local src="$2"

    if [ "${src}" = "manjaro" ]
    then
        sudo pacman -S "${app}" --noconfirm --needed
    fi
    
    if [ "${src}" = "aur" ]
    then
        pamac build "${app}" --noconfirm
    fi

    if [ "${src}" = "flatpak" ]
    then
        flatpack install "${app}"  --noninteractive
    fi

    if [ "${src}" = "pip" ]
    then
        pip install "${app}" 
    fi
}

apps::install
