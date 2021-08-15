if status is-interactive
    # Commands to run in interactive sessions can go here
end

# some bobthefish settings

set -g theme_newline_cursor yes
set -g theme_newline_prompt "> "
set -g theme_display_user yes
set -g theme_color_scheme solarized-dark

function gs # shorthand for git status
    git status
end

function ga # shorthand for git add
    git add $argv
end

function gc # shorthand for git commit
    git commit $argv
end

function tkdclub # shorthand to go into project
    cd /home/markus/Projekte/tkdclub
end

# Gtk-theme shorthands

function mojave
    cd ~/Projekte/Mojave-gtk-theme
    git pull
    sudo ~/Projekte/McMojave-gtk-theme/install.sh -c dark -o solid -i manjaro -g
end