{ lib, ... }:
{
    imports = [
        ../home-manager/default.nix
    ];

    config = {
        # Enable custom module options
        # NOTE: Make sure to disable nixvim lsp, cmp, jdtls, and vimtex when building
        apeiron = {
            hyprDE.enable = true;
            isStandalone = false;

            desktop = {
                applications = {
                    cider.enable = false;
                    jan.enable = false;
                    mousepad.enable = false;
                    mpv.enable = false;
                    obs.enable = false;
                    thunderbird.enable = false;
                };

                utilities.swaylock.enable = false;
            };

            terminal = {
                cryfs.enable = false;
                git.enable = true;
                wlclip.enable = false;
            };

            services.mako.enable = false;
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
