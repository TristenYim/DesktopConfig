{ config, lib, ... }: {

    # Set a toggle to enable Qt
    options.apeiron = {
        qt.enable = lib.mkEnableOption "Qt";
    };
 
    config = lib.mkIf config.apeiron.qt.enable 
    {
        qt = {
            enable = true;
        };
    };
}
