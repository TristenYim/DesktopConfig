{ ... }:

{
    imports = [
        ./tdoggy-default.nix
    ];

    config = {
        neofetch-home.enable = true;
        persistence-home.enable = true;
        isStandalone = false;

        home.sessionVariables = {
            FLAKE = "/etc/nixos";
        };
    };
}
