{ config, lib, ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            terminal.brightnessctl.enable = true;
            persistence.enable = true;
            isStandalone = false;
        };

        programs.nixvim.plugins.orgmode.settings.org_agenda_files = "/media/Sync/Notes/Todo.org";

        wayland.windowManager = {
            mango.configAttrs.monitorrule = let
                masterRatio = lib.strings.floatToString config.apeiron.desktop.compositors.settings.behavior.layouts.master.ratio;
            in [
                # Let the resolution be determined automatically.
                "eDP-1,${masterRatio},1,tile,0,1,0,0,0,0,0"
            ];
        };

        home = {
            sessionVariables = {
                FLAKE = "/etc/nixos";
            };
        };
    };
}
