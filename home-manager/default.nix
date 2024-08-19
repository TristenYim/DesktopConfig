{ config, pkgs, lib, ... }: 

{
    imports = [
        ./desktop-apps.nix
        ./image-utils.nix
        ./firefox/firefox.nix
        ./terminal/alias.nix
        ./terminal/bash.nix
        ./terminal/git.nix
        ./terminal/kitty.nix
        ./terminal/ranger.nix
        ./terminal/starship.nix
        ./terminal/zsh.nix
        ./nixGL/nixGLOpt.nix
        ./nixvim/nixvim.nix
        ./hypr/hyprland.nix
        ./rofi/rofi.nix
        ./swaylock/swaylock.nix
        ./theme/catppuccin.nix
        ./theme/cursor.nix
        ./theme/gtk.nix
        ./theme/qt.nix
        ./waybar/waybar.nix
        ./wlogout/wlogout.nix
        ./xfce.nix
    ];
    
    options = {
        hyprDE-home.enable = lib.mkEnableOption "Enables my custom Hyprland desktop environment";
        xfce-home.enable = lib.mkEnableOption "Enables XFCE";
    };

    # DE-independent defaults
    config = lib.mkMerge 
    [
        {
            alias-home.enable = lib.mkDefault true;
            bash-home.enable = lib.mkDefault true;
            catppuccin-home.enable = lib.mkDefault true;
            cursor-home.enable = lib.mkDefault true;
            firefox-home.enable = lib.mkDefault true;
            gtk-home.enable = lib.mkDefault true;
            nixvim-home.enable = lib.mkDefault true;
            ranger-home.enable = lib.mkDefault true;
            qt-home.enable = lib.mkDefault true;
            starship-home.enable = lib.mkDefault true;
            # zsh-home.enable = lib.mkDefault true;
            nixGLPrefix = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";
        }

        ( lib.mkIf config.hyprDE-home.enable {
            # hycov-home.enable = lib.mkDefault true; # We'll worry about this later
            hyprland-home.enable = lib.mkDefault true;
            hypridle-home.enable = lib.mkDefault true;
            kitty-home.enable = lib.mkDefault true;
            rofi-home.enable = lib.mkDefault true;
            screenshot-home.enable = lib.mkDefault true;
            swaylock-home.enable = lib.mkDefault true;
            waybar-home.enable = lib.mkDefault true;
            wlogout-home.enable = lib.mkDefault true;
        })

        ( lib.mkIf config.xfce-home.enable {
            xfconf-home.enable = lib.mkDefault true;
        })
    ];
}
