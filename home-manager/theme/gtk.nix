{ config, pkgs, lib, ... }: {

    # Set a toggle to enable GTK
    options.apeiron = {
        gtk.enable = lib.mkEnableOption "GTK";
    };
 
    config = lib.mkIf config.apeiron.gtk.enable 
    {
        gtk = {
            enable = true;
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
