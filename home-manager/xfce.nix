{ config, lib, myLib, ... }: {
    imports = [
        ( myLib.home.mkPersistenceModule [ ] [ ".nvidia-settings-rc" ] [ "desktop" "xfce" "xfconf" ] ) # These settings are only relevant for gaming
    ];

    # Set a toggle to override Xfce settings
    options.apeiron.desktop.xfce = {
        xfconf.enable = lib.mkEnableOption "XFCE configuration";
    };
 
    config = lib.mkIf config.apeiron.desktop.xfce.xfconf.enable {
        xfconf.settings = {
            xfce4-keyboard-shortcuts = {
                "commands/custom/override" = true;
                "commands/custom/<Super>apostrophe" = "exo-open --launch TerminalEmulator";
                "commands/custom/<Super>grave" = "exo-open --launch TerminalEmulator btop";
                "commands/custom/<Super>j" = "xfce4-screenshotter";
                "commands/custom/<Super>q" = "exo-open --launch WebBrowser";
                "commands/custom/<Super>space" = "xfce4-appfinder";
                "commands/custom/<Super>u" = "thunar";
            };
            xfce4-terminal = {
                "run-custom-command" = true;
                "custom-command" = "zsh";
            };
            xfwm4 = {
                "general/use_compositing" = false;
            };
            xsettings = {
                "Net/ThemeName" = "catppuccin-mocha-lavender-standard+default";
            };
        };

        # Setting display settings declaratively doesn't make sense when
        # it's so setup-dependent, so it is being persisted instead.
        home.persistence."/pers/${config.home.homeDirectory}" = lib.mkIf config.apeiron.persistence.enable {
            files = [ ".config/xfce4/xfconf/xfce-perchannel-xml/displays.xml" ];
        };
    };
}
