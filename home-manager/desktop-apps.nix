{ config, pkgs, lib, ... }: 

{
    options = {
        forRobotics-home.enable = lib.mkEnableOption "Enables common apps I use for robotics";
        forSchool-home.enable = lib.mkEnableOption "Enables common apps I use for school";

        anki-home.enable = lib.mkEnableOption "Enables Anki";
        bottles-home.enable = lib.mkEnableOption "Use Bottles!";
        chromium-home.enable = lib.mkEnableOption "Enables Chromium";
        cider-home.enable = lib.mkEnableOption "Enables Cider";
        copyq-home.enable = lib.mkEnableOption "Enables CopyQ";
        cryfs-home.enable = lib.mkEnableOption "Enables CryFS";
        darktable-home.enable = lib.mkEnableOption "Enables darktable";
        libreOffice-home.enable = lib.mkEnableOption "Enables LibreOffice";
        grimSwappy-home.enable = lib.mkEnableOption "Enables grim + swappy screenshot tools";
        mako-home.enable = lib.mkEnableOption "Enables mako";
        mousepad-home.enable = lib.mkEnableOption "Enables Mousepad";
        mpv-home.enable = lib.mkEnableOption "Enables mpv";
        neofetch-home.enable = lib.mkEnableOption "Enables neofetch";
        obs-home.enable = lib.mkEnableOption "Enables OBS Studio";
        prusaSlicer-home.enable = lib.mkEnableOption "Enables PrusaSlicer";
        qalculate-home.enable = lib.mkEnableOption "Enables Qalculate!";
        slack-home.enable = lib.mkEnableOption "Enables Slack";
        zoom-home.enable = lib.mkEnableOption "Enables Zoom";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [

        # These are apps that should really be on every system with a GUI.
        {
            chromium-home.enable = lib.mkDefault true;
            cider-home.enable = lib.mkDefault true;
            cryfs-home.enable = lib.mkDefault true;
            mousepad-home.enable = lib.mkDefault true;
            mpv-home.enable = lib.mkDefault true;
            neofetch-home.enable = lib.mkDefault true;
            obs-home.enable = lib.mkDefault true;
            qalculate-home.enable = lib.mkDefault true;
        }

        # HyprDE
        ( lib.mkIf config.hyprDE-home.enable {
            copyq-home.enable = lib.mkDefault true;
            feh-home.enable = lib.mkDefault true;
            grimSwappy-home.enable = lib.mkDefault true;
            mako-home.enable = lib.mkDefault true;
        })

        # For School
        ( lib.mkIf config.forSchool-home.enable {
            anki-home.enable = lib.mkDefault true;
            libreOffice-home.enable = lib.mkDefault true;
            zoom-home.enable = lib.mkDefault true;
        })

        # For Robotics
        ( lib.mkIf config.forRobotics-home.enable {
            prusaSlicer-home.enable = lib.mkDefault true;
            slack-home.enable = lib.mkDefault true;
        })

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

        # LibreOffice
        ( lib.mkIf config.libreOffice-home.enable {
            home.packages = [ pkgs.libreoffice-fresh ];
        })

        # mako
        ( lib.mkIf config.mako-home.enable {
            home.packages = [ pkgs.mako ];
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

        # Zoom
        ( lib.mkIf config.zoom-home.enable {
            home.packages = [ pkgs.zoom-us ];
        })
    ];
}
