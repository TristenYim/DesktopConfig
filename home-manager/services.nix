# These are Systemd services that do not need to be enabled system-wide.

{ config, pkgs, lib, myLib, ... }: {
    imports = [
        ( myLib.home.mkPersistenceModule [ ".config/OpenRGB" ] [ ] [ "openrgb" ] )
    ];

    options.apeiron = {
        mako.enable = lib.mkEnableOption "mako";
        openrgb.enable = lib.mkEnableOption "openrgb profile persistence";
        playerctld.enable = lib.mkEnableOption "playerctld";
        polkit-agent.enable = lib.mkEnableOption "polkit KDE agent";
    };
 
    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # mako
        ( lib.mkIf config.apeiron.mako.enable {
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
        ( lib.mkIf config.apeiron.playerctld.enable {
            services.playerctld.enable = true;
        })
       
        # polkit KDE agent
        ( lib.mkIf config.apeiron.polkit-agent.enable {
            home.packages = [
                pkgs.polkit_gnome
            ];
            systemd.user.services.polkit-gnome = {
                Unit = {
                    Description = "PolicyKit-gnome provides an Authentication Agent for PolicyKit that integrates well with the GNOME desktop environment.";
                    PartOf = [ "graphical-session.target" ];
                    After = [ "graphical-session-pre.target" ];
                };
                Service = {
                    Type = "simple";
                    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                    Restart = "on-failure";
                    RestartSec = 1;
                    TimeoutStopSec = 10;
                };
                Install.WantedBy = [ "graphical-session.target" ];
            };
        })
    ];
}
