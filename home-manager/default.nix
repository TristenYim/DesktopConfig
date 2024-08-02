{ config, pkgs, lib, ... }: 

{
    imports = [
        ./terminal/bash.nix
        ./terminal/git.nix
        ./terminal/kitty.nix
        ./terminal/ranger.nix
        ./terminal/starship.nix
        ./nixGL/nixGLOpt.nix
        ./nixvim/nixvim.nix
        ./hypr/hyprland.nix
        ./rofi/rofi.nix
        ./swaylock/swaylock.nix
        ./waybar/waybar.nix
        ./wlogout/wlogout.nix
        ./catppuccin.nix
        ./firefox.nix
        ./xfce.nix
    ];
    
    options = {
        hyprDE.enable = lib.mkEnableOption "Enables my custom Hyprland DE";
        xfceDE.enable = lib.mkEnableOption "Enables XFCE";
    };

    # DE-independent defaults
    config = lib.mkMerge 
    [
        {
            bash-home.enable = lib.mkDefault true;
            catppuccin-home.enable = lib.mkDefault true;
            firefox-home.enable = lib.mkDefault true;
            nixvim-home.enable = lib.mkDefault true;
            ranger-home.enable = lib.mkDefault true;
            starship-home.enable = lib.mkDefault true;
            nixGLPrefix = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";
        }

        ( lib.mkIf config.hyprDE.enable {
        #   hyprland-home.enable = lib.mkDefault true;
            kitty-home.enable = lib.mkDefault true;
            rofi-home.enable = lib.mkDefault true;
            swaylock-home.enable = lib.mkDefault true;
            waybar-home.enable = lib.mkDefault true;
            wlogout-home.enable = lib.mkDefault true;
        })

        ( lib.mkIf config.xfceDE.enable {
            xfconf-home.enable = lib.mkDefault true;
        })
    ];
}
