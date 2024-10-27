# These are terminal packages with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        cryfs-home.enable = lib.mkEnableOption "Enables CryFS";
        neofetch-home.enable = lib.mkEnableOption "Enables neofetch";
        wlclip-home.enable = lib.mkEnableOption "Enables WL clip";
    };

    config = lib.mkMerge [
        ( myLib.home.enablePkgSameOptName "cryfs" )
        ( myLib.home.enablePkgSameOptName "neofetch" )
        ( myLib.home.enablePkgWith "wl-clipboard-rs" "wlclip" )
    ];
}
