# Configuration for the persistence of files with home manager.
# See https://github.com/nix-community/impermanence for more info.

{ config, lib, ... }: {
    options = {
        persistence-home.enable = lib.mkEnableOption "persistence of files in an impermanence configuration";
    };

    config = lib.mkIf config.persistence-home.enable {
        home.persistence."/pers/${config.home.homeDirectory}" = {
            directories = [
                # The Freedesktop directories, except for useless ones like "Desktop"
                "Documents"
                "Music"
                "Pictures"
                "Videos"

                ".ssh" # Stores a lot of information, including github keys and trusted host
                ".local/share/fonts" # Local fonts
            ];
            files = [
                ".command_history"
            ];
            allowOther = true;
        };
    };
}
