{ config, pkgs, lib, inputs, ... }: {

    options = {
        hycov-home.enable = lib.mkEnableOption "Enables the hycov plugin with Home Manager";
    };

    config = lib.mkIf config.hycov-home.enable
    {
        wayland.windowManager.hyprland = {
            plugins = [
                # inputs.hycov.packages."${pkgs.system}".hycov
            ];

            # settings = {
            # };
        };
    };
}
