{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{

    # Set a toggle to override Xfce settings
    options = {
        xfconf-home.enable = lib.mkEnableOption "XFCE configuration";
    };
 
    config = lib.mkMerge [
        ( myLib.home.persistIf "xfconf" [ ] [ ".nvidia-settings-rc" ] ) # These settings are only relevant for gaming
            
        ( lib.mkIf config.xfconf-home.enable {
            xfconf.settings =
            {
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
        })
    ];
}
