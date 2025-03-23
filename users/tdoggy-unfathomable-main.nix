{ ... }:

{
    imports = [
        ./tdoggy-default.nix
    ];

    config = {
        neofetch-home.enable = true;
        persistence-home.enable = true;

        home.sessionVariables = {
            FLAKE = "/etc/nixos";
        };
    };
}
