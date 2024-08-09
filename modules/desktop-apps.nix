{ config, pkgs, lib, ... }: {
    options = {
        chromium.enable = lib.mkEnableOption "Enables Cider";
        cider.enable = lib.mkEnableOption "Enables Cider";
        firefox.enable = lib.mkEnableOption "Enables Firefox";
        mousepad.enable = lib.mkEnableOption "Enables Mousepad";
        obs.enable = lib.mkEnableOption "Enables OBS Studio";
        qalculate.enable = lib.mkEnableOption "Enables Qalculate!";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            chromium.enable = lib.mkDefault true;
            cider.enable = lib.mkDefault true;
            firefox.enable = lib.mkDefault true;
            mousepad.enable = lib.mkDefault true;
            qalculate.enable = lib.mkDefault true;
        }

        # Chromium
        ( lib.mkIf config.chromium.enable {
            environment.systemPackages = [
                pkgs.chromium
            ];
        })

        # Cider
        ( lib.mkIf config.cider.enable {
            environment.systemPackages = [
                pkgs.cider
            ];
        })

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

        # OBS Studio
        ( lib.mkIf config.obs.enable {
            environment.systemPackages = [
                pkgs.obs-studio
            ];
        })

        # Qalculate!
        ( lib.mkIf config.qalculate.enable {
            environment.systemPackages = [
                pkgs.qalculate-qt
            ];
        })
    ];
}
