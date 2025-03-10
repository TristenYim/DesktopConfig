{ config, lib, ... }: {

    # Set a toggle to override Xfce settings
    options = {
        xfconf-home.enable = lib.mkEnableOption "Enables XFCE configuration with home manager";
    };
 
    config = lib.mkIf config.xfconf-home.enable 
    {
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
            xfwm4 = {
                "general/use_compositing" = false;
            };
        };
    };
}
