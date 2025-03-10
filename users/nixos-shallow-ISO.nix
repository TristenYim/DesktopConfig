{ pkgs, lib, inputs, ... }:
{
    imports = [
        ../home-manager/default.nix
    ];

    config = {
        git-home.enable = true;
        hyprDE-home.enable = true;

        cider-home.enable = false;
        cryfs-home.enable = false;
        mousepad-home.enable = false;
        mpv-home.enable = false;
        obs-home.enable = false;
        wlclip-home.enable = false;
        thunderbird-home.enable = false;

        copyq-home.enable = false;
        mako-home.enable = false;
        playerctld-home.enable = false;

        # For some reason, hycov is broken on the USB. Oh well
        hycov-home.enable = false;

        # Reset packages to default instead of nixGL wrapped ones on NixOS
        programs.kitty.package = pkgs.kitty;

        wayland.windowManager.hyprland = {
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            settings = {
                "$mon1" = "";
            };
            systemd.enable = false;
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
