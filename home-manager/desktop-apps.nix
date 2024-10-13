# These are desktop apps with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    # Adds a set of packages when an enable option is true.
    # Note that since every option in my home-manager configuration adds
    # "-home" to the end of its option names, the "-home" is excluded
    # from the argument.
    enableHomePkgsWith = packageList: optionNameWithoutHome:
        lib.mkIf config.${optionNameWithoutHome + "-home"}.enable { 
            home.packages = packageList; 
        };

    # Enables a single package when an option name is true.
    enableHomePkgWith = packageName: optionNameWithoutHome:
        enableHomePkgsWith [ pkgs.${packageName} ] optionNameWithoutHome;

    # Enables a single package with an identically named option.
    enableHomePkgSameOptName = name:
        enableHomePkgWith name name;
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
        ( enableHomePkgSameOptName "anki" )
        ( enableHomePkgSameOptName "bottles" )
        ( enableHomePkgSameOptName "cider" )
        ( enableHomePkgSameOptName "copyq" )
        ( enableHomePkgSameOptName "darktable" )
        ( enableHomePkgWith "file-roller" "fileRoller" )
        ( enableHomePkgSameOptName "heroic" )
        ( enableHomePkgWith "libreoffice-fresh" "libreOffice" )
        ( enableHomePkgsWith [ pkgs.xfce.mousepad ] "mousepad" )
        ( enableHomePkgSameOptName "mpv" )
        ( enableHomePkgWith "obs-studio" "obs" )
        ( enableHomePkgWith "octaveFull" "octave" )
        ( enableHomePkgWith "prusa-slicer" "prusaSlicer" )
        ( enableHomePkgWith "qalculate-qt" "qalculate" )
        ( enableHomePkgSameOptName "slack" )
        ( enableHomePkgSameOptName "steam" )
        ( enableHomePkgsWith [ pkgs.wpsoffice pkgs.liberation_ttf ] "wps" )
        ( enableHomePkgWith "zoom-us" "zoom" )

        ( lib.mkIf config.chromium-home.enable {
            programs.chromium = {
                enable = true;
            };
        })

        # For an unknown reason, the line below doesn't work
        # ( enableHomePkgWith "xfce.mousepad" "mousepad" )
    ];
}
