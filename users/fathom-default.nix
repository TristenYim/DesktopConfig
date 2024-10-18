{ config, pkgs, lib, ... }:
{
    imports = [
        ../home-manager/default.nix
        ../overlays/hyprland-overlay.nix
    ];

    # Override local module defaults
    git-home.enable = lib.mkDefault true;
    hyprDE-home.enable = lib.mkDefault true;
    forSchool-home.enable = lib.mkDefault true;
    forRobotics-home.enable = lib.mkDefault true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = lib.mkDefault true;

    home = {
        username = lib.mkDefault "fathom";
        homeDirectory = lib.mkDefault "/home/fathom";

        sessionVariables = {
            FLAKE = lib.mkDefault "~/nix";
            EDITOR = lib.mkDefault "nvim";
        };

        stateVersion = lib.mkDefault "24.05";
    };
}
