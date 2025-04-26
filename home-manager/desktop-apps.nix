# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config lib; };
in
{
    options.apeiron = {
        anki.enable = lib.mkEnableOption "Anki";
        bottles.enable = lib.mkEnableOption "Use Bottles!";
        chromium.enable = lib.mkEnableOption "Chromium";
        cider.enable = lib.mkEnableOption "Cider";
        copyq.enable = lib.mkEnableOption "CopyQ";
        darktable.enable = lib.mkEnableOption "darktable";
        fileRoller.enable = lib.mkEnableOption "File Roller (For managing archives)";
        heroic.enable = lib.mkEnableOption "Heroic Games Launcher (For playing Epic Games)";
        jan.enable = lib.mkEnableOption "Jan local AI";
        libreOffice.enable = lib.mkEnableOption "LibreOffice";
        mousepad.enable = lib.mkEnableOption "Mousepad";
        mpv.enable = lib.mkEnableOption "mpv";
        obs.enable = lib.mkEnableOption "OBS Studio";
        octave.enable = lib.mkEnableOption "GNU Octave";
        wps.enable = lib.mkEnableOption "WPS Office";
        prusaSlicer.enable = lib.mkEnableOption "PrusaSlicer";
        prismLauncher.enable = lib.mkEnableOption "PrusaSlicer";
        qalculate.enable = lib.mkEnableOption "Qalculate!";
        slack.enable = lib.mkEnableOption "Slack";
        steam.enable = lib.mkEnableOption "Steam";
        zoom.enable = lib.mkEnableOption "Zoom";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        ( with pkgs; myLib.home.enableEachPkgWith [
            [ anki "anki" ]
            [ bottles "bottles" ]
            [ cider "cider" ]
            [ copyq "copyq" ]
            [ darktable "darktable" ]
            [ file-roller "fileRoller" ]
            [ heroic "heroic" ]
            [ jan "jan" ]
            [ libreoffice-fresh "libreOffice" ]
            [ mpv "mpv" ]
            [ obs-studio "obs" ]
            [ octaveFull "octave" ]
            [ prismlauncher "prismLauncher" ]
            [ prusa-slicer "prusaSlicer" ]
            [ qalculate-qt "qalculate" ]
            [ slack "slack" ]
            [ steam "steam" ]
            [ wpsoffice "wps" ]
            [ liberation_ttf "wps" ]
            [ xfce.mousepad "mousepad" ]
            [ zoom-us "zoom" ]
        ])
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

        ( lib.mkIf config.apeiron.chromium.enable {
            programs.chromium = {
                enable = true;
            };
        })
    ];
}
