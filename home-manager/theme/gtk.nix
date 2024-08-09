{ config, pkgs, lib, ... }: {

    # Set a toggle to enable GTK
    options = {
        gtk-home.enable = lib.mkEnableOption "Enables GTK with Home Manager";
    };
 
    config = lib.mkIf config.gtk-home.enable 
    {
        gtk = {
            enable = true;
            cursorTheme = {
                name = "Qogir-dark";
                package = pkgs.qogir-icon-theme;
                size = 24;
            };
            font = {
                name = "System-ui";
                size = 12;
            };
            iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.papirus-icon-theme;
            };
        };
    };
}
