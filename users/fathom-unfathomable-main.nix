{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./fathom-default.nix
        ./persist-home-unfathomable-main.nix
        ./../secrets/home.nix # This contains information that's too sensitive to put on github
    ];

    config = {
        bottles-home.enable = true;
        darktable-home.enable = true;
        neofetch-home.enable = true;

        # Reset packages to default instead of nixGL wrapped ones on NixOS
        programs.kitty.package = pkgs.kitty;

        wayland.windowManager.hyprland = {
            package = inputs.hyprland.packages."${pkgs.system}".hyprland; # For hycov
            settings = {
                ################
                ### MONITORS ###
                ################
    
                "$mon1" = "HDMI-A-1";
                "$mon2" = "DP-1";
    
                # See https://wiki.hyprland.org/Configuring/Monitors/ for more
                monitor = [
                    "HDMI-A-1,2560x1440@60,0x0,1.0"
                    "DP-1,1920x1080@120,2560x0,1.0"
                ];
            };
        };

        home.file = {
            ".local/share/Anki2" = {
                source = config.lib.file.mkOutOfStoreSymlink /media/Hdd/SchoolNotes/Anki2; # Lets me save my flashcards in my school notes repo
            };
        };
    };
}
