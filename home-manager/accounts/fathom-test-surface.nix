{ config, pkgs, lib, ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        # Enable configuration of Firefox
        firefox-home.enable = lib.mkForce false;
        hyprland-home.enable = lib.mkForce true;

        # Reset packages to default instead of nixGL wrapped ones on NixOS
        programs.kitty.package = pkgs.kitty;
        wayland.windowManager.hyprland.package = pkgs.hyprland;
    };
}
