{ config, pkgs, lib, ... }: {

    # Set a toggle to enable cursor configuration
    # By default, this is disabled
    options = {
        cursor-home.enable = lib.mkEnableOption "Enables cursor configuration with Home Manager";
    };
 
    config = lib.mkIf config.cursor-home.enable 
    {
        home.pointerCursor = {
            name = "Qogir-dark";
            package = pkgs.qogir-icon-theme;
            size = 24;
            x11.enable = true;
            gtk.enable = true;
        };
    };
}
