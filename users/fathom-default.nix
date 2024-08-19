{ config, pkgs, lib, ... }:
{
    imports = [
        ../home-manager/default.nix
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

        sessionVariables = lib.mkDefault {
            EDITOR = "nvim";
        };

        stateVersion = lib.mkDefault "24.05"; # Please read the comment in ../home-manager/resources/default.nix before changing.
    };
}
