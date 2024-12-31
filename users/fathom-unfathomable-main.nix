{ config, pkgs, inputs, ... }:
{
    imports = [
        ./fathom-default.nix
        ./persist-fathom-unfathomable-main.nix
        ./../secrets/home.nix # This contains information that's too sensitive to put on github
    ];

    config = {
        # bottles-home.enable = true;
        darktable-home.enable = true;
        neofetch-home.enable = true;
        zsh-home.enable = true;

        # Reset packages to default instead of nixGL wrapped ones on NixOS
        programs.kitty.package = pkgs.kitty;

        wayland.windowManager.hyprland = {
            # package = pkgs.hyprland; # For hycov
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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

        programs.waybar = 
        let
            makeBar = ( import ../home-manager/waybar/makeBar.nix );
            styler = ( import ../home-manager/waybar/styleMaker.nix );
        in
        {
            settings =
            [   
                (makeBar "bar1" "HDMI-A-1")
                (makeBar "bar2" "DP-1")
            ];
            style = (
                styler.makeGlobal + 
                styler.makeUnique "bar1" 24 10 10 21 10 + 
                styler.makeUnique "bar2" 20 8 8 18 8
            );
        };

        home = {
            sessionVariables = {
                FLAKE = "/etc/nixos";
            };

            file = {
                ".local/share/Anki2" = {
                    source = config.lib.file.mkOutOfStoreSymlink /media/Hdd/SchoolNotes/Anki2; # Lets me save my flashcards in my school notes repo
                };
            };
        };
    };
}
