{ config, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config lib; };
in
{
    imports = [
        ./ethanol.nix
        ./affinity.nix
    ];

    # It might seem confusing to have two separate options for ethanol, but 
    # they serve different purposes. programs.ethanol controls the generic
    # implementation of ethanol, while ethanol-home controls MY ethanol
    # configuration. Basically, think of programs.ethanol as a part of Home
    # Manager itself, while ethanol-home is part of my configuration.
    options = {
        ethanol-home.enable = lib.mkEnableOption "ethanol";
    };

    config = lib.mkMerge [
        ( lib.mkIf (config.ethanol-home.enable) {
            programs.ethanol.enable = true;
        })
        ( myLib.home.persistIf "ethanol" [ ".local/share/ethanol" ] [ ] )
    ];
}
