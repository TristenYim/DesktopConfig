{ config, lib, ... }: 
{
    imports = [
        ../home-manager/default.nix
    ];

    # Override local module defaults
    apeiron = {
        xfce.enable = lib.mkDefault true;  
        desktop.applications.bottles.enable = true;

        gaming = {
            heroic.enable = true;
            prismLauncher.enable = true;
            steam.enable = true;
        };
    };

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

        # Game-specific persistence
        persistence."/pers/home/tdoggy" = lib.mkIf config.apeiron.persistence.enable {
            directories = [ ".local/share/PUNKCAKE Delicieux/Shotgun King - The Final Checkmate" ];
        };
    };
}
