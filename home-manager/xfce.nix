{ config, pkgs, lib, myLib, ... }: {
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
                # Used for generating a launch executable action from a default app
                actionFromApp = app: if ! builtins.hasAttr "flags" app then lib.getExe app else lib.getExe app.package + " " + app.flags;

                # Generates one or more binds sharing a dispatcher from the compositor-agnostic keybind format
                mkBinds = keys: action: 
                    let
                        convertList = i:
                            let
                                e = builtins.elemAt keys i;
                                modList = [ "SUPER" "SHIFT" "ALT" ];
                            in if ! builtins.elem e modList then lib.toLower e else "<${e}>" + convertList (i + 1);
                    in { "commands/custom/${convertList 0}" = action; };
            in {
                "commands/custom/override" = true;
            }
            // mkBinds [ "SUPER" "grave" ] "exo-open --launch TerminalEmulator btop"
            // lib.mergeAttrsList (builtins.map (bind: mkBinds bind.keys (actionFromApp bind.app)) config.apeiron.desktop.compositors.settings.keybinds.launchers);

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
