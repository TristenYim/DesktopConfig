{ config, pkgs, lib, inputs, ... }:

# Import the nixGL wrapper
let nixGLWrap = import ../home-manager/nixGL/nixGLWrapper.nix { 
    inherit config pkgs; 
};
in {
    imports = [
        ./fathom-default.nix
    ];

    config = {
        forRobotics-home.enable = false;

        # Broken outside of nixos
        anki-home.enable = false;
        zoom-home.enable = false;

        # Remove unneeded apps to save space
        chromium-home.enable = false;
        polkit-agent-home.enable = false;
        obs-home.enable = false;

        wayland.windowManager.hyprland = {
            # package = nixGLWrap pkgs.hyprland; # For hycov
            package = nixGLWrap inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            settings = {
                ################
                ### MONITORS ###
                ################
    
                "$mon1" = "eDP-1";
                "$mon2" = "$mon1";
    
                # See https://wiki.hyprland.org/Configuring/Monitors/ for more
                monitor = [
                    "$mon1,1920x1080@60,0x0,1.0"
                ];
            };
        };

        home.file = {
            ".local/share/Anki2" = {
                source = config.lib.file.mkOutOfStoreSymlink Documents/SchoolNotes/Anki2; # Lets me save my flashcards in my school notes repo
            };
        };
            
        nixpkgs.config.allowUnfree = lib.mkDefault true;
    };
}
