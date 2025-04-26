{ ... }:

{
    imports = [
        ./tdoggy-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            neofetch.enable = true;
            persistence.enable = true;
            isStandalone = false;
        };

        home.sessionVariables = {
            FLAKE = "/etc/nixos";
        };
    };
}
