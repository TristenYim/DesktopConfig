{ config, lib, ... }:
{
    imports = [
        ./fathom-default.nix
        ./../secrets/home.nix # This contains information that's too sensitive to put on github
    ];

    config = {
        # Enable custom module options
        apeiron = {
            persistence.enable = true;
            nvidia.enable = true;
            isStandalone = false;

            ethanol = {
                enable = true;
                affinity.enable = true;
            };

            mangoDE.enable = true;

            services.openrgb.enable = true;

            terminal = {
                neofetch.enable = true;
                optnix.hostname = "unfathomable-main";
            };

            # work.darktable.enable = true; # Currently relies on an old insecure version of a library, re-enable once updated
        };

        programs.nixvim.plugins.orgmode.settings.org_agenda_files = "/media/Hdd/Sync/Notes/Todo.org";

        # Set compositor monitor settings
        wayland.windowManager = {
            mango.configAttrs.monitorrule = let
                masterRatio = lib.strings.floatToString config.apeiron.desktop.compositors.settings.behavior.layouts.master.ratio;
            in [
                # Let the resolution be determined automatically since mango is for
                # some reason setting the wrong resolution, but only if manually
                # configured.
                "HDMI-A-1,${masterRatio},1,tile,0,1,0,0,0,0,60"
                "DP-1,${masterRatio},1,tile,0,1,2560,0,0,0,144" # TODO figure out how to make mango respect resolution
            ];
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
