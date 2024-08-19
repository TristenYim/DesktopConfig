# Declares persistent files and directories in /home
# These are NOT erased on reboot in the impermanence setup
{ config, pkgs, lib, ... }: {
    home.persistence."/pers/home/fathom" = {
        directories = [

            # The Freedesktop directories, except for useless ones like "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Videos"

            ".ssh" # Stores a lot of information, including github keys and trusted host
            ".local/share/nvim/site/spell" # Nvim spell-check files
            ".local/share/fonts" # Local fonts
            ".mozilla/firefox/user" # All firefox data
        ];
        files = [
            ".bash_history" # Stores command history
        ];
        allowOther = true;
    };
}
