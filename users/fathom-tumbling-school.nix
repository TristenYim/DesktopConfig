{ config, lib, ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            forRobotics.enable = false;
            nixGL.enable = true;

            desktop = {
                applications = {
                    jan.enable = false;
                    obs.enable = false;
                };

                browsers.chromium.enable = false;

                hyprland.uglyAFMode.default = true;
            };

            # Remove unneeded apps to save space
            services.polkit-agent.enable = false;

            # Broken outside of nixos
            work = {
                anki.enable = false;
                zoom.enable = false;
            };
        };

        programs.nixvim.plugins.orgmode.settings.org_agenda_files = "/home/fathom/Documents/Sync/Notes/Todo.org";

        wayland.windowManager.hyprland = {
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
