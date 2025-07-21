# Defines shared desktop-agnostic keybinds.
# The implementations for how these keybinds are interpreted are
# defined in each DE/WM's configuration files.

{ config, lib, ... }: 
let
    # Submodule representing a single keybind
    keybindType = lib.types.submodule {
        options = {
            keys = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "The key combination to assign.";
            };
            action = lib.mkOption {
                type = lib.types.str;
                default = "";
                description = "The associated action.";
            };
        };
    };

    # Attribute set representing a category of keybinds
    mkKeybindAttrsOption = roleDescription: lib.mkOption {
        type = lib.types.attrsOf keybindType;
        default = { };
        description = "Desktop-agnostic keybinds that ${roleDescription}.";
    };
in
{
    options.apeiron.desktop.keybinds = {
        launchers = mkKeybindAttrsOption "launch common programs";
    };

    config = {
        apeiron.desktop.keybinds = {
            launchers = {
                appLauncher = {
                    keys = [ "SUPER" "SPACE" ];
                    action = lib.getExe config.apeiron.desktop.defaultApps.appLauncher;
                };
                browser = {
                    keys = [ "SUPER" "Q" ];
                    action = lib.getExe config.apeiron.desktop.defaultApps.browser;
                };
                fileManager = {
                    keys = [ "SUPER" "U" ];
                    action = lib.getExe config.apeiron.desktop.defaultApps.fileManager;
                };
                terminalEmulator = {
                    keys = [ "SUPER" "APOSTROPHE" ];
                    action = lib.getExe config.apeiron.desktop.defaultApps.terminalEmulator;
                };
            };
        };
    };
}
