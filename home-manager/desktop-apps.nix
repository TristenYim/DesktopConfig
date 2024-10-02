# These are (mostly) GUI apps that do not need to be installed system-wide.

{ config, pkgs, lib, ... }: 

{
    options = {
        anki-home.enable = lib.mkEnableOption "Enables Anki";
        bottles-home.enable = lib.mkEnableOption "Use Bottles!";
        chromium-home.enable = lib.mkEnableOption "Enables Chromium";
        cider-home.enable = lib.mkEnableOption "Enables Cider";
        copyq-home.enable = lib.mkEnableOption "Enables CopyQ";
        cryfs-home.enable = lib.mkEnableOption "Enables CryFS";
        darktable-home.enable = lib.mkEnableOption "Enables darktable";
        fileRoller-home.enable = lib.mkEnableOption "Enables File Roller";
        libreOffice-home.enable = lib.mkEnableOption "Enables LibreOffice";
        mousepad-home.enable = lib.mkEnableOption "Enables Mousepad";
        mpv-home.enable = lib.mkEnableOption "Enables mpv";
        neofetch-home.enable = lib.mkEnableOption "Enables neofetch";
        obs-home.enable = lib.mkEnableOption "Enables OBS Studio";
        octave-home.enable = lib.mkEnableOption "Enables GNU Octave";
        wps-home.enable = lib.mkEnableOption "Enables ONLYOFFICE";
        prusaSlicer-home.enable = lib.mkEnableOption "Enables PrusaSlicer";
        qalculate-home.enable = lib.mkEnableOption "Enables Qalculate!";
        slack-home.enable = lib.mkEnableOption "Enables Slack";
        zoom-home.enable = lib.mkEnableOption "Enables Zoom";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # Anki
        ( lib.mkIf config.anki-home.enable {
            home.packages = [ pkgs.anki ];
        })

        # Use Bottles! GUI Wine bottler
        ( lib.mkIf config.bottles-home.enable {
            home.packages = [ pkgs.bottles ];
        })

        # Chromium
        ( lib.mkIf config.chromium-home.enable {
            programs.chromium = {
                enable = true;
            };
        })

        # Cider
        ( lib.mkIf config.cider-home.enable {
            home.packages = [ pkgs.cider ];
        })

        # CopyQ, clipboard manager
        ( lib.mkIf config.copyq-home.enable {
            home.packages = [ pkgs.copyq ];
        })

        # CryFS, encryption tool
        ( lib.mkIf config.cryfs-home.enable {
            home.packages = [ pkgs.cryfs ];
        })

        # darktable
        ( lib.mkIf config.darktable-home.enable {
            home.packages = [ pkgs.darktable ];
        })

        # File Roller
        ( lib.mkIf config.fileRoller-home.enable {
            home.packages = [ pkgs.file-roller ];
        })

        # LibreOffice
        # NOTE: This option may be deprecated soon, I'm experimenting
        # with WPS office, which appears to be much more compatible
        # with MS office.
        ( lib.mkIf config.libreOffice-home.enable {
            home.packages = [ pkgs.libreoffice-fresh ];
        })

        # Mousepad
        ( lib.mkIf config.mousepad-home.enable {
            home.packages = [ pkgs.xfce.mousepad ];
        })

        # mpv
        ( lib.mkIf config.mpv-home.enable {
            home.packages = [ pkgs.mpv ];
        })

        # Neofetch
        ( lib.mkIf config.neofetch-home.enable {
            home.packages = [ pkgs.neofetch ];
        })

        # OBS Studio
        ( lib.mkIf config.obs-home.enable {
            home.packages = [ pkgs.obs-studio ];
        })

        # GNU Octave
        ( lib.mkIf config.octave-home.enable {
            home.packages = [ pkgs.octaveFull ];
        })

        # PrusaSlicer
        ( lib.mkIf config.prusaSlicer-home.enable {
            home.packages = [ pkgs.prusa-slicer ];
        })

        # Qalculate!
        ( lib.mkIf config.qalculate-home.enable {
            home.packages = [ pkgs.qalculate-qt ];
        })

        # Slack
        ( lib.mkIf config.slack-home.enable {
            home.packages = [ pkgs.slack ];
        })

        # WPS Office
        ( lib.mkIf config.wps-home.enable {
            home.packages = [ pkgs.wpsoffice pkgs.liberation_ttf ];
        })

        # Zoom
        ( lib.mkIf config.zoom-home.enable {
            home.packages = [ pkgs.zoom-us ];
        })
    ];
}
