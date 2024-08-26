{ config, pkgs, lib, ... }:

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
            package = pkgs.hyprland;
            # package = pkgs24-05.hyprland;
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
    };
}
