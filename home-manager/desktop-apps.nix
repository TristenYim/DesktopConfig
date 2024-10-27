# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        anki-home.enable = lib.mkEnableOption "Enables Anki";
        bottles-home.enable = lib.mkEnableOption "Use Bottles!";
        chromium-home.enable = lib.mkEnableOption "Enables Chromium";
        cider-home.enable = lib.mkEnableOption "Enables Cider";
        copyq-home.enable = lib.mkEnableOption "Enables CopyQ";
        darktable-home.enable = lib.mkEnableOption "Enables darktable";
        fileRoller-home.enable = lib.mkEnableOption "Enables File Roller (For managing archives)";
        heroic-home.enable = lib.mkEnableOption "Enables Heroic Games Launcher (For playing Epic Games)";
        libreOffice-home.enable = lib.mkEnableOption "Enables LibreOffice";
        mousepad-home.enable = lib.mkEnableOption "Enables Mousepad";
        mpv-home.enable = lib.mkEnableOption "Enables mpv";
        obs-home.enable = lib.mkEnableOption "Enables OBS Studio";
        octave-home.enable = lib.mkEnableOption "Enables GNU Octave";
        wps-home.enable = lib.mkEnableOption "Enables WPS Office";
        prusaSlicer-home.enable = lib.mkEnableOption "Enables PrusaSlicer";
        qalculate-home.enable = lib.mkEnableOption "Enables Qalculate!";
        slack-home.enable = lib.mkEnableOption "Enables Slack";
        steam-home.enable = lib.mkEnableOption "Enables Steam";
        zoom-home.enable = lib.mkEnableOption "Enables Zoom";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        ( myLib.home.enablePkgSameOptName "anki" )
        ( myLib.home.enablePkgSameOptName "bottles" )
        ( myLib.home.enablePkgSameOptName "cider" )
        ( myLib.home.enablePkgSameOptName "copyq" )
        ( myLib.home.enablePkgSameOptName "darktable" )
        ( myLib.home.enablePkgWith "file-roller" "fileRoller" )
        ( myLib.home.enablePkgSameOptName "heroic" )
        ( myLib.home.enablePkgWith "libreoffice-fresh" "libreOffice" )
        ( myLib.home.enablePkgsWith [ pkgs.xfce.mousepad ] "mousepad" )
        ( myLib.home.enablePkgSameOptName "mpv" )
        ( myLib.home.enablePkgWith "obs-studio" "obs" )
        ( myLib.home.enablePkgWith "octaveFull" "octave" )
        ( myLib.home.enablePkgWith "prusa-slicer" "prusaSlicer" )
        ( myLib.home.enablePkgWith "qalculate-qt" "qalculate" )
        ( myLib.home.enablePkgSameOptName "slack" )
        ( myLib.home.enablePkgSameOptName "steam" )
        ( myLib.home.enablePkgsWith [ pkgs.wpsoffice pkgs.liberation_ttf ] "wps" )
        ( myLib.home.enablePkgWith "zoom-us" "zoom" )

        ( lib.mkIf config.chromium-home.enable {
            programs.chromium = {
                enable = true;
            };
        })

        # For an unknown reason, the line below doesn't work
        # ( myLib.home.enablePkgWith "xfce.mousepad" "mousepad" )
    ];
}
