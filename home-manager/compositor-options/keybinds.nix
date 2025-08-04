# Defines shared desktop-agnostic keybinds.
# The implementations for how these keybinds are interpreted are
# defined in each DE/WM's configuration files.

{ config, lib, ... }: 
let
    # Submodule representing a app launcher keybind
    launchbindType = lib.types.submodule {
        options.keys = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "The key combination to assign.";
        };
        options.app = lib.mkOption {
            type = lib.types.either lib.types.package lib.types.attrs;
            default = "";
            description = "The associated app to launch.";
        };
    };

    # Generates a simple bind option attribute set
    mkBindOption = descriptionExtra: lib.mkOption {
        type = lib.types.attrsOf 
            <| lib.types.listOf 
            <| lib.types.either lib.types.str (lib.types.listOf lib.types.str);
        default = [ ];
        description = "Compositor-agnostic ${descriptionExtra} keybinds.";
    };
in
{
    options.apeiron.desktop.compositors.settings.keybinds = {
        launchers = lib.mkOption {
            type = lib.types.listOf launchbindType;
            default = [ ];
            description = "Compositor-agnostic program launcher keybinds.";
        };
        scratchpads = mkBindOption "scratchpad toggle";
        windowManagement = mkBindOption "window management";
    };

    config.apeiron.desktop.compositors.settings.keybinds = {
        launchers = [
            {
                keys = [ "SUPER" "SPACE" ];
                app = config.apeiron.desktop.defaultApps.appLauncher;
            }
            {
                keys = [ "SUPER" "Q" ];
                app = config.apeiron.desktop.defaultApps.browser;
            }
            {
                keys = [ "SUPER" "U" ];
                app = config.apeiron.desktop.defaultApps.fileManager;
            }

            # Currently broken in Xfce because it uses an absolutely stupid keybind
            # system where SHIFT + KEY is for some reason SHIFT + SHIFTED CHARACTER
            {
                keys = [ "SUPER" "SHIFT" "SEMICOLON" ];
                app = config.apeiron.desktop.defaultApps.logoutMenu;
            }

            {
                keys = [ "SUPER" "APOSTROPHE" ];
                app = config.apeiron.desktop.defaultApps.terminalEmulator;
            }
            { 
                keys = [ "SUPER" "SEMICOLON" ];
                app = config.apeiron.desktop.defaultApps.screenlocker;
            }
            { 
                keys = [ "SUPER" "J" ];
                app = config.apeiron.desktop.defaultApps.screenshotter;
            }
        ];

        scratchpads = {
            btop = [ "SUPER" "B" ];
            cider = [ "SUPER" "P" ];
            config = [ "SUPER" "M" ];
            agenda = [ "SUPER" "W" ];
        };

        windowManagement = {
            cycleMasterFromTop = [ "SUPER" "S" ];
            focusLeft = [ [ "SUPER" "A" ] [ "SUPER" "LEFT" ] ];
            focusRight = [ [ "SUPER" "E" ] [ "SUPER" "RIGHT" ] ];
            focusUp = [ [ "SUPER" "COMMA" ] [ "SUPER" "UP" ] ];
            focusDown = [ [ "SUPER" "O" ] [ "SUPER" "DOWN" ] ];
            kill = [ [ "SUPER" "ESCAPE" ] [ "SUPER" "BACKSPACE" ] ];
            swapLeft = [ [ "SUPER" "H" ] [ "SUPER" "SHIFT" "A" ] [ "SUPER" "SHIFT" "LEFT" ] ];
            swapRight = [ [ "SUPER" "N" ] [ "SUPER" "SHIFT" "E" ] [ "SUPER" "SHIFT" "RIGHT" ] ];
            swapUp = [ [ "SUPER" "C" ] [ "SUPER" "SHIFT" "COMMA" ] [ "SUPER" "SHIFT" "UP" ] ];
            swapDown = [ [ "SUPER" "T" ] [ "SUPER" "SHIFT" "O" ] [ "SUPER" "SHIFT" "DOWN" ] ];
            quit = [ "SUPER" "SHIFT" "R" ];
            toggleFloat = [ "SUPER" "PERIOD" ];
        };
    };
}
