{ lib, ... }:
{
    imports = [
        ../home-manager/default.nix
    ];

    config = {
        # Enable custom module options
        # NOTE: Make sure to disable nixvim lsp, cmp, jdtls, and vimtex when building
        apeiron = {
            git.enable = true;
            hyprDE.enable = true;
            isStandalone = false;

            cider.enable = false;
            cryfs.enable = false;
            copyq.enable = false;
            jan.enable = false;
            mako.enable = false;
            mousepad.enable = false;
            mpv.enable = false;
            obs.enable = false;
            swaylock.enable = false;
            wlclip.enable = false;
            thunderbird.enable = false;

            # For some reason, hycov is broken on the USB. Oh well
            hyprland.plugins.hycov.enable = false;
        };

        wayland.windowManager.hyprland = {
            settings = {
                "$mon1" = "";
            };
        };

        home = {
            username = "nixos";
            homeDirectory = "/home/nixos";

            sessionVariables = {
                FLAKE = "/etc/nixos";
            };

            stateVersion = lib.trivial.release;
        };
    };
}
