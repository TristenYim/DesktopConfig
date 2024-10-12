{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./tdoggy-default.nix
        ./persist-tdoggy-unfathomable-main.nix
    ];

    config = {
        neofetch-home.enable = true;
    };
}
