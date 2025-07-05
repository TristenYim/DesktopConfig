# These are terminal packages with little to no special configurations that don't need to be installed system-wide

{ pkgs, myLib, ... }: {
    imports = with pkgs; myLib.mapCalls (myLib.home.mkPkgModule) [
        [ cryfs [ "terminal" "cryfs" ] ]
        [ neofetch [ "terminal" "neofetch" ] ]
        [ wl-clipboard-rs [ "terminal" "wlclip" ] ]
        [ brightnessctl [ "terminal" "brightnessctl" ] ]
    ];
}
