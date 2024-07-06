{ config, pkgs, lib, ... }: {
    options = {
        firefox.enable = lib.mkEnableOption "Enables Firefox";
        mousepad.enable = lib.mkEnableOption "Enables Mousepad";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # Firefox
        ( lib.mkIf config.firefox.enable {
            environment.systemPackages = [
                pkgs.firefox
            ];
        })

        # Mousepad
        ( lib.mkIf config.mousepad.enable {
            environment.systemPackages = [
                pkgs.xfce.mousepad
            ];
        })
    ];
}
