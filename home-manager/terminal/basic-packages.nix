# These are terminal packages with little to no special configurations that don't need to be installed system-wide

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
        cryfs-home.enable = lib.mkEnableOption "Enables CryFS";
        neofetch-home.enable = lib.mkEnableOption "Enables neofetch";
    };

    config = lib.mkMerge [
        ( enableHomePkgSameOptName "cryfs" )
        ( enableHomePkgSameOptName "neofetch" )
    ];
}
