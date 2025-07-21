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
            xfce4-keyboard-shortcuts = let
                toXfConf = myLib.keybinds.toXfConf;
            in {
                "commands/custom/override" = true;
            }
            // toXfConf [ "SUPER" "grave" ] "exo-open --launch TerminalEmulator btop"
            // toXfConf [ "SUPER" "j" ] "xfce4-screenshotter"
            // lib.mergeAttrsList (lib.mapAttrsToList (name: value: toXfConf value.keys value.action) config.apeiron.desktop.keybinds.launchers);

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
