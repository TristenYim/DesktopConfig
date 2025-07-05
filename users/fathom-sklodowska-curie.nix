{ ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            desktop.hyprland.uglyAFMode.default = true;
            terminal.brightnessctl.enable = true;
            persistence.enable = true;
            isStandalone = false;
        };

        programs.nixvim.plugins.orgmode.settings.org_agenda_files = "/media/Sync/Notes/Todo.org";

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

        home = {
            sessionVariables = {
                FLAKE = "/etc/nixos";
            };
        };
    };
}
