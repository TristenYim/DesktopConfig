# These are terminal packages with little to no special configurations that don't need to be installed system-wide

{ pkgs, myLib, ... }: {
    imports = with pkgs; [
        ( myLib.home.mkPkgModule cryfs [ "cryfs" ] )
        ( myLib.home.mkPkgModule neofetch [ "neofetch" ] )
        ( myLib.home.mkPkgModule wl-clipboard-rs [ "wlclip" ] )
    ];
}
