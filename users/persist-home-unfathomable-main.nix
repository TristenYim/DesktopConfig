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

            ".local/fathom/.local/share/nvim/site/spell" # Nvim spell-check files
            ".local/share/fonts" # Local fonts
        ];
        files = [
            ".bash_history"
        ];
        allowOther = true;
    };
}
