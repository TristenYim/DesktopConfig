{ config, pkgs, lib, ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        hyprland-home.enable = true;

        # Reset packages to default instead of nixGL wrapped ones on NixOS
        programs.kitty.package = pkgs.kitty;
        wayland.windowManager.hyprland.package = pkgs.hyprland;
    };
}
