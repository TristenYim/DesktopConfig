# These are Systemd services that do not need to be enabled system-wide.

{ config, pkgs, lib, ... }: 

{
    options = {
        mako-home.enable = lib.mkEnableOption "Enables mako";
        playerctld-home.enable = lib.mkEnableOption "Enables playerctld";
    };
 
    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # mako
        ( lib.mkIf config.mako-home.enable {
            services.mako = {
                enable = true;
                borderRadius = 5;
                borderSize = 2;
                font = "Merienda 10";
            };
            home.packages = [ 
                pkgs.libnotify
            ];
        })
       
        # playerctld
        ( lib.mkIf config.playerctld-home.enable {
            services.playerctld.enable = true;
        })
    ];
}
