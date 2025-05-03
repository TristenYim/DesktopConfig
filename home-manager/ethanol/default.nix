{ config, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config lib; };
in
{
    imports = [
        ./ethanol.nix
        ./affinity.nix

        ( myLib.home.mkPersistenceModule [ ".local/share/ethanol" ] [ ] [ "ethanol" ] )
    ];

    # It might seem confusing to have two separate options for ethanol, but 
    # they serve different purposes. programs.ethanol controls the generic
    # implementation of ethanol, while ethanol-home controls MY ethanol
    # configuration. Basically, think of programs.ethanol as a part of Home
    # Manager itself, while ethanol-home is part of my configuration.
    options.apeiron = {
        ethanol.enable = lib.mkEnableOption "ethanol";
    };

    config = lib.mkIf (config.apeiron.ethanol.enable) {
        programs.ethanol.enable = true;
    };
}
