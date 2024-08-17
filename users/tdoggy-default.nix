{ config, pkgs, lib, ... }: 
{
    imports = lib.mkDefault [
        ../default.nix
    ];

    # Override local module defaults
    xfconf-home.enable = lib.mkDefault true;  

    # Let Home Manager install and manage itself
    programs.home-manager.enable = lib.mkDefault true;

    home = {
        username = lib.mkDefault "tdoggy";
        homeDirectory = lib.mkDefault "/home/tdoggy";

        sessionVariables = lib.mkDefault {
            EDITOR = "nvim";
        };
    
        stateVersion = lib.mkDefault "24.05"; # Please read the comment in ../home-manager/resources/default.nix before changing
    };
}
