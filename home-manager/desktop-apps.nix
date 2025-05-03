# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config lib; };
in
{
    imports = with pkgs; [
        ( myLib.home.mkPkgModule anki [ "anki" ] )
        ( myLib.home.mkPkgModule bottles [ "bottles" ] )
        ( myLib.home.mkPkgModule cider [ "cider" ] )
        ( myLib.home.mkPkgModule copyq [ "copyq" ] )
        ( myLib.home.mkPkgModule darktable [ "darktable" ] )
        ( myLib.home.mkPkgModule file-roller [ "fileRoller" ] )
        ( myLib.home.mkPkgModule heroic [ "heroic" ] )
        ( myLib.home.mkPkgModule jan [ "jan" ] )
        ( myLib.home.mkPkgModule libreoffice-fresh [ "libreOffice" ] )
        ( myLib.home.mkPkgModule xfce.mousepad [ "mousepad" ] )
        ( myLib.home.mkPkgModule mpv [ "mpv" ] )
        ( myLib.home.mkPkgModule obs-studio [ "obs" ] )
        ( myLib.home.mkPkgModule octaveFull [ "octave" ] )
        ( myLib.home.mkPkgModule prismlauncher [ "prismLauncher" ] )
        ( myLib.home.mkPkgModule prusa-slicer [ "prusaSlicer" ] )
        ( myLib.home.mkPkgModule qalculate-qt [ "qalculate" ] )
        ( myLib.home.mkPkgModule slack [ "slack" ] )
        ( myLib.home.mkPkgModule steam [ "steam" ] )
        ( myLib.home.mkPkgModule zoom-us [ "zoom" ] )

        ( myLib.home.mkPkgsModule [ wpsoffice liberation_ttf ] [ "wps" ] )
    ];

    options.apeiron = {
        chromium.enable = lib.mkEnableOption "Chromium";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
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
