{ config, pkgs, lib, ... }: {
    options = {
        anki.enable = lib.mkEnableOption "Enables Anki";
        darktable.enable = lib.mkEnableOption "Enables darktable";
        libreOffice.enable = lib.mkEnableOption "Enables LibreOffice";
        prusaSlicer.enable = lib.mkEnableOption "Enables PrusaSlicer";
        slack.enable = lib.mkEnableOption "Enables Slack";
        zoom.enable = lib.mkEnableOption "Enables Zoom";
    };
    
    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            anki.enable = lib.mkDefault true;
            libreOffice.enable = lib.mkDefault true;
            slack.enable = lib.mkDefault true;
            zoom.enable = lib.mkDefault true;
        }

        # Anki
        ( lib.mkIf config.anki.enable {
            environment.systemPackages = [
                pkgs.anki
            ];
        })

        # darktable
        ( lib.mkIf config.darktable.enable {
            environment.systemPackages = [
                pkgs.darktable
            ];
        })

        # LibreOffice
        ( lib.mkIf config.libreOffice.enable {
            environment.systemPackages = [
                pkgs.libreoffice-fresh
            ];
        })

        # PrusaSlicer
        ( lib.mkIf config.prusaSlicer.enable {
            environment.systemPackages = [
                pkgs.prusa-slicer
            ];
        })

        # Slack
        ( lib.mkIf config.slack.enable {
            environment.systemPackages = [
                pkgs.slack
            ];
        })

        # Zoom
        ( lib.mkIf config.zoom.enable {
            environment.systemPackages = [
                pkgs.zoom
            ];
        })
    ];
}
