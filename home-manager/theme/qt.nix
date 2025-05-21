{ config, lib, ... }: {

    # Set a toggle to enable Qt
    options.apeiron.desktop.theme = {
        qt.enable = lib.mkEnableOption "Qt";
    };
 
    config = lib.mkIf config.apeiron.desktop.theme.qt.enable 
    {
        qt = {
            enable = true;
        };
    };
}
