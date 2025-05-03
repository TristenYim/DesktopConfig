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

        ( myLib.home.mkPersistenceModule [ ".local/share/bottles" ] [ ] [ "bottles" ] )
        ( myLib.home.mkPersistenceModule [ ".config/Cider/Themes" ".config/sh.cider.classic" ] [ ] [ "cider" ] )
        ( myLib.home.mkPersistenceModule [ ".config/heroic" ] [ ] [ "heroic" ] )
        ( myLib.home.mkPersistenceModule [ ".config/Jan" ] [ ] [ "jan" ] )
        ( myLib.home.mkPersistenceModule [ ".local/share/PrismLauncher" ] [ ] [ "prismLauncher" ] )
        ( myLib.home.mkPersistenceModule [ ".config/PrusaSlicer" ] [ ] [ "prusaSlicer" ] )
        ( myLib.home.mkPersistenceModule [ ".config/Slack" ] [ ] [ "slack" ] )
        ( myLib.home.mkPersistenceModule [ ".local/share/Steam" ] [ ] [ "steam" ] )
    ];

    options.apeiron = {
        chromium.enable = lib.mkEnableOption "Chromium";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkIf config.apeiron.chromium.enable {
        programs.chromium = {
            enable = true;
        };
    };
}
