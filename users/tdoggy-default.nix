{ lib, ... }: 
{
    imports = [
        ../home-manager/default.nix
    ];

    # Override local module defaults
    xfce-home.enable = lib.mkDefault true;  
    bottles-home.enable = true;
    steam-home.enable = true;
    heroic-home.enable = true;

    # Let Home Manager install and manage itself
    programs.home-manager.enable = lib.mkDefault true;

    home = {
        username = lib.mkDefault "tdoggy";
        homeDirectory = lib.mkDefault "/home/tdoggy";

        sessionVariables = {
            FLAKE = lib.mkDefault "$HOME/nix";
            EDITOR = lib.mkDefault "nvim";
        };
    
        stateVersion = lib.mkDefault "24.05"; 
    };
}
