{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Qt
    options = {
        qt-home.enable = lib.mkEnableOption "Qt";
    };
 
    config = lib.mkIf config.qt-home.enable 
    {
        qt = {
            enable = true;
        };
    };
}
