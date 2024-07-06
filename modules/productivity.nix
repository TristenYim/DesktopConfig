{ config, pkgs, lib, ... }: {
    options = {
        darktable.enable = lib.mkEnableOption "Enables darktable";
        libreOffice.enable = lib.mkEnableOption "Enables LibreOffice";
        slack.enable = lib.mkEnableOption "Enables Slack";
        zoom.enable = lib.mkEnableOption "Enables Zoom";
    };
    
    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            libreOffice.enable = lib.mkDefault true;
            slack.enable = lib.mkDefault true;
            zoom.enable = lib.mkDefault true;
        }

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
