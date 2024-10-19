# Declares persistent files and directories in /home
# These are NOT erased on reboot in the impermanence setup
{ config, pkgs, lib, ... }: {
    home.persistence."/pers/home/tdoggy" = {
        directories = [

            # The Freedesktop directories, except for useless ones like "Desktop"
            "Documents"
            "Music"
            "Pictures"
            "Videos"

            ".ssh" # Stores a lot of information, including github keys and trusted host
            ".config/heroic" # Heroic data
            ".local/share/nvim/site/spell" # Nvim spell-check files
            ".local/share/bottles" # Use Bottles! for gaming
            ".local/share/Steam" # Steam user data
            ".mozilla/firefox/user" # Firefox user profile
            ".config/Cider/Themes" # Cider themes
            ".config/sh.cider.classic" # Cider data
        ];
        files = [
            ".bash_history" # Stores command history
        ];
        allowOther = true;
    };
}
