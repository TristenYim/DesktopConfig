# Declares persistent in /home
# These are NOT erased on reboot in the impermanence setup
{ config, pkgs, lib, ... }: {
    home.persistence."/pers/home/fathom" = {
        directories = [
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Videos"
        ];
        files = [
            ".bash_history"
        ];
        allowOther = true;
    };
}
