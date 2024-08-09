{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Qt
    options = {
        qt-home.enable = lib.mkEnableOption "Enables Qt with Home Manager";
    };
 
    config = lib.mkIf config.qt-home.enable 
    {
        qt = {
            enable = true;
        };
    };
}
