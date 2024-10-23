{ config, lib, ... }: 
let
    catppuccin = (import ./theme/catppuccin-colors.nix);
in
{
    options = {
        swaylock-home.enable = lib.mkEnableOption "Enables swaylock with Home Manager";
    };
 
    config = lib.mkIf config.swaylock-home.enable 
    {
        home.file.".config/swaylock/config" = {
            text = ''
                bs-hl-color=${catppuccin.rosewater}
                caps-lock-bs-hl-color=${catppuccin.rosewater}
                caps-lock-key-hl-color=${catppuccin.green}
                clock
                color=${catppuccin.base}
                daemonize
                effect-blur=8x6
                effect-vignette=0.5:0.5
                fade-in=0.400000
                font=Merienda
                grace=0
                hide-keyboard-layout
                ignore-empty-password
                indicator
                indicator-caps-lock
                indicator-radius=300
                indicator-thicknes=20
                inside-caps-lock-color=${catppuccin.base}80
                inside-clear-color=#f2d5cf80
                inside-color=${catppuccin.base}80
                inside-ver-color=#8caaee80
                inside-wrong-color=#ea999c80
                key-hl-color=${catppuccin.green}
                layout-bg-color=#00000000
                layout-border-color=#00000000
                layout-text-color=${catppuccin.text}
                line-caps-lock-color=#ef9f76ff
                line-clear-color=#f2d5cfff
                line-color=#232634ff
                line-ver-color=#8caaeeff
                line-wrong-color=#ea999cff
                ring-caps-lock-color=${catppuccin.peach}
                ring-clear-color=${catppuccin.rosewater}
                ring-color=${catppuccin.lavender}
                ring-ver-color=${catppuccin.blue}
                ring-wrong-color=${catppuccin.maroon}
                screenshots
                separator-color=#232634ff
                show-failed-attempts
                text-caps-lock-color=${catppuccin.peach}
                text-clear-color=${catppuccin.rosewater}
                text-color=${catppuccin.text}
                text-ver-color=${catppuccin.blue}
                text-wrong-color=${catppuccin.maroon}
            '';
        };

        # I may consider adding conditional logic so the config is defined using the module on NixOS.
        # Swaylock will not unlock if configured with just Home Manager, which is why I don't do this.
        # Alternatively, it may make sense to just leave the configuration like this.
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
    };
}
