{ config, pkgs, lib, ... }: {

    # Set a toggle to enable cursor configuration
    # By default, this is disabled
    options.apeiron.desktop.theme = {
        cursor.enable = lib.mkEnableOption "cursor configuration";
    };
 
    config = lib.mkIf config.apeiron.desktop.theme.cursor.enable 
    {
        home.pointerCursor = {
            enable = true;
            name = "Qogir-Dark";
            package = pkgs.qogir-icon-theme;
            size = 24;
            x11.enable = true;
            gtk.enable = true;
        };
    };
}
