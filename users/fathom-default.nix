{ lib, ... }:
{
    imports = [
        ../home-manager/default.nix
    ];

    # Custom module defaults
    apeiron = {
        git.enable = lib.mkDefault true;
        jan.enable = lib.mkDefault true;

        hyprDE.enable = lib.mkDefault true;
        forSchool.enable = lib.mkDefault true;
        forRobotics.enable = lib.mkDefault true;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = lib.mkDefault true;

    home = {
        username = lib.mkDefault "fathom";
        homeDirectory = lib.mkDefault "/home/fathom";

        sessionVariables = {
            FLAKE = lib.mkDefault "$HOME/nix";
            EDITOR = lib.mkDefault "nvim";
        };

        stateVersion = lib.mkDefault "24.05";
    };
}
