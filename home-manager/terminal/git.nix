{ config, pkgs, lib, ... }: {

    # Set a toggle to enable git
    options = {
        git-home.enable = lib.mkEnableOption "Enables git with Home Manager";
    };
 
    config = lib.mkIf config.git-home.enable 
    {
        programs.git = {
            enable = true;
            userEmail = "unfathomy@proton.me";
            userName = "TristenYim";
            extraConfig = {
                safe = {
                    directory = [
                        "/etc/nixos"
                    ];
                };
            };
        };
    };
}
