# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, myLib, ... }: {
    imports = with pkgs; [ 
        ( myLib.home.mkPkgsModule [ wpsoffice liberation_ttf ] [ "work" "wps" ] ) 
    ]
    ++ myLib.mapCalls (myLib.home.mkPkgModule)
    [
        [ anki [ "work" "anki" ] ]
        [ bottles [ "desktop" "applications" "bottles" ] ]
        [ cider [ "desktop" "applications" "cider" ] ]
        [ darktable [ "work" "darktable" ] ]
        [ file-roller [ "desktop" "utilities" "fileRoller" ] ]
        [ heroic [ "gaming" "heroic" ] ]
        [ jan [ "desktop" "applications" "jan" ] ]
        [ xfce.mousepad [ "desktop" "applications" "mousepad" ] ]
        [ mpv [ "desktop" "applications" "mpv" ] ]
        [ obs-studio [ "desktop" "applications" "obs" ] ]
        [ octaveFull [ "work" "octave" ] ]
        [ prismlauncher [ "gaming" "prismLauncher" ] ]
        [ prusa-slicer [ "work" "prusaSlicer" ] ]
        [ qalculate-qt [ "desktop" "applications" "qalculate" ] ]
        [ slack [ "work" "slack" ] ]
        [ steam [ "gaming" "steam" ] ]
        [ zoom-us [ "work" "zoom" ] ]
    ]
    ++ myLib.mapCalls (myLib.home.mkPersistenceModule)
    [
        [ [ ".local/share/bottles" ] [ ] [ "desktop" "applications" "bottles" ] ]
        [ [ ".config/Cider/Themes" ".config/sh.cider.classic" ] [ ] [ "desktop" "applications" "cider" ] ]
        [ [ ".config/heroic" ] [ ] [ "gaming" "heroic" ] ]
        [ [ ".config/Jan" ] [ ] [ "desktop" "applications" "jan" ] ]
        [ [ ".local/share/PrismLauncher" ] [ ] [ "gaming" "prismLauncher" ] ]
        [ [ ".config/PrusaSlicer" ] [ ] [ "work" "prusaSlicer" ] ]
        [ [ ".config/Slack" ] [ ] [ "work" "slack" ] ]
        [ [ ".local/share/Steam" ] [ ] [ "gaming" "steam" ] ]
    ];

    options.apeiron = {
        desktop.browsers.chromium.enable = lib.mkEnableOption "Chromium";
    };

    config = lib.mkIf config.apeiron.desktop.browsers.chromium.enable {
        programs.chromium = {
            enable = true;
        };
    };
}
