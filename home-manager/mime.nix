# Defines what apps work with what filetypes, and what should be the default

{ config, lib, ... }: {

    options = {
        mime-home.enable = lib.mkEnableOption "Enables MIME app management";
    };

    config = ( lib.mkIf config.mime-home.enable {
        xdg.mimeApps = {
            enable = true;
            associations.added = {
                "text/plain" = "org.xfce.mousepad.desktop;";
                "image/jpeg" = "feh.desktop;";
                "image/png" = "feh.desktop;";
                "image/x-canon-cr2" = "feh.desktop;";
                "application/pdf" = "firefox-beta.desktop;";
            };
            defaultApplications = {
                "image/jpeg" = "feh.desktop;";
                "image/png" = "feh.desktop;";
                "image/x-canon-cr2" = "feh.desktop;";
                "application/pdf" = "firefox-beta.desktop;";
            };
        };
    });
}
