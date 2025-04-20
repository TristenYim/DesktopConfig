# These are terminal packages with little to no special configurations that don't need to be installed system-wide

{ config, pkgs, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config lib; };
in
{
    options = {
        cryfs-home.enable = lib.mkEnableOption "CryFS";
        neofetch-home.enable = lib.mkEnableOption "neofetch";
        wlclip-home.enable = lib.mkEnableOption "Enables WL clip";
    };

    config = with pkgs; myLib.home.enableEachPkgWith [
        [ cryfs "cryfs" ]
        [ neofetch "cryfs" ]
        [ wl-clipboard-rs "wlclip" ]
    ];
}
