# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        anki-home.enable = lib.mkEnableOption "Anki";
        bottles-home.enable = lib.mkEnableOption "Use Bottles!";
        chromium-home.enable = lib.mkEnableOption "Chromium";
        cider-home.enable = lib.mkEnableOption "Cider";
        copyq-home.enable = lib.mkEnableOption "CopyQ";
        darktable-home.enable = lib.mkEnableOption "darktable";
        fileRoller-home.enable = lib.mkEnableOption "File Roller (For managing archives)";
        heroic-home.enable = lib.mkEnableOption "Heroic Games Launcher (For playing Epic Games)";
        jan-home.enable = lib.mkEnableOption "Jan local AI";
        libreOffice-home.enable = lib.mkEnableOption "LibreOffice";
        mousepad-home.enable = lib.mkEnableOption "Mousepad";
        mpv-home.enable = lib.mkEnableOption "mpv";
        obs-home.enable = lib.mkEnableOption "OBS Studio";
        octave-home.enable = lib.mkEnableOption "GNU Octave";
        wps-home.enable = lib.mkEnableOption "WPS Office";
        prusaSlicer-home.enable = lib.mkEnableOption "PrusaSlicer";
        prismLauncher-home.enable = lib.mkEnableOption "PrusaSlicer";
        qalculate-home.enable = lib.mkEnableOption "Qalculate!";
        slack-home.enable = lib.mkEnableOption "Slack";
        steam-home.enable = lib.mkEnableOption "Steam";
        zoom-home.enable = lib.mkEnableOption "Zoom";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        ( myLib.home.enableEachPkgWith [
            [ "anki" "anki" ]
            [ "bottles" "bottles" ]
            [ "cider" "cider" ]
            [ "copyq" "copyq" ]
            [ "darktable" "darktable" ]
            [ "file-roller" "fileRoller" ]
            [ "heroic" "heroic" ]
            [ "jan" "jan" ]
            [ "libreoffice-fresh" "libreOffice" ]
            [ "mpv" "mpv" ]
            [ "obs-studio" "obs" ]
            [ "octaveFull" "octave" ]
            [ "prismlauncher" "prismLauncher" ]
            [ "prusa-slicer" "prusaSlicer" ]
            [ "qalculate-qt" "qalculate" ]
            [ "slack" "slack" ]
            [ "steam" "steam" ]
            [ "wpsoffice" "wps" ]
            [ "liberation_ttf" "wps" ]
            [ "zoom-us" "zoom" ]
        ])
        ( myLib.home.enablePkgsWith [ pkgs.xfce.mousepad ] "mousepad" )
        ( myLib.home.persistEachIf [
            [ "bottles" [ ".local/share/bottles" ] [ ] ]
            [ "cider" [ ".config/Cider/Themes" ".config/sh.cider.classic" ] [ ] ]
            [ "heroic" [ ".config/heroic" ] [ ] ]
            [ "jan" [ ".config/Jan" ] [ ] ]
            [ "prismLauncher" [ ".local/share/PrismLauncher" ] [ ] ]
            [ "prusaSlicer" [ ".config/PrusaSlicer" ] [ ] ]
            [ "slack" [ ".config/Slack" ] [ ] ]
            [ "steam" [ ".local/share/Steam" ] [ ] ]
        ])

        ( lib.mkIf config.chromium-home.enable {
            programs.chromium = {
                enable = true;
            };
        })
    ];
}
