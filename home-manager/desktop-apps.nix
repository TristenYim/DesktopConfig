# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, myLib, ... }: {
    imports = with pkgs; [ 
        ( myLib.home.mkPkgsModule [ wpsoffice liberation_ttf ] [ "wps" ] ) 
    ]
    ++ myLib.mapCalls (myLib.home.mkPkgModule)
    [
        [ anki [ "anki" ] ]
        [ bottles [ "bottles" ] ]
        [ cider [ "cider" ] ]
        [ copyq [ "copyq" ] ]
        [ darktable [ "darktable" ] ]
        [ file-roller [ "fileRoller" ] ]
        [ heroic [ "heroic" ] ]
        [ jan [ "jan" ] ]
        [ libreoffice-fresh [ "libreOffice" ] ]
        [ xfce.mousepad [ "mousepad" ] ]
        [ mpv [ "mpv" ] ]
        [ obs-studio [ "obs" ] ]
        [ octaveFull [ "octave" ] ]
        [ prismlauncher [ "prismLauncher" ] ]
        [ prusa-slicer [ "prusaSlicer" ] ]
        [ qalculate-qt [ "qalculate" ] ]
        [ slack [ "slack" ] ]
        [ steam [ "steam" ] ]
        [ zoom-us [ "zoom" ] ]
    ]
    ++ myLib.mapCalls (myLib.home.mkPersistenceModule)
    [
        [ [ ".local/share/bottles" ] [ ] [ "bottles" ] ]
        [ [ ".config/Cider/Themes" ".config/sh.cider.classic" ] [ ] [ "cider" ] ]
        [ [ ".config/heroic" ] [ ] [ "heroic" ] ]
        [ [ ".config/Jan" ] [ ] [ "jan" ] ]
        [ [ ".local/share/PrismLauncher" ] [ ] [ "prismLauncher" ] ]
        [ [ ".config/PrusaSlicer" ] [ ] [ "prusaSlicer" ] ]
        [ [ ".config/Slack" ] [ ] [ "slack" ] ]
        [ [ ".local/share/Steam" ] [ ] [ "steam" ] ]
    ];

    options.apeiron = {
        chromium.enable = lib.mkEnableOption "Chromium";
    };

    config = lib.mkIf config.apeiron.chromium.enable {
        programs.chromium = {
            enable = true;
        };
    };
}
