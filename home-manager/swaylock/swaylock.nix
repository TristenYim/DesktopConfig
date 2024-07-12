{ config, pkgs, lib, ... }: {

    # Set a toggle to enable swaylock
    options = {
        swaylock-home.enable = lib.mkEnableOption "Enables swaylock with Home Manager";
    };
 
    config = lib.mkIf config.swaylock-home.enable 
    {

      # TODO: Add conditional logic so it works normally on NixOS.
      # Swaylock will not unlock if configured with just Home Manager.
      # programs.swaylock = {
      #     enable = true;
      #     package = pkgs.swaylock-effects;
      #     settings = {
      #         ignore-empty-password = true;
      #         show-failed-attempts = true;
      #         daemonize = true;
      #         hide-keyboard-layout = true;
      #         indicator-caps-lock = true;
      #         font = "Merienda";
      #         indicator-radius = 300;
      #         indicator-thicknes = 20;
      #         screenshots = true;
      #         clock = true;
      #         indicator = true;
      #         grace = 30;
      #         fade-in = 0.4;
      #         effect-blur = "8x6";
      #         effect-vignette = "0.5:0.5";
      #     };
      # };

        home.file = {
            ".config/swaylock/config" = {
                source = config.lib.file.mkOutOfStoreSymlink ./config;
            };
        };
    };
}
