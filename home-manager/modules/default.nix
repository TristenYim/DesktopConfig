{ config, pkgs, lib, ... }: 

{
    imports = [
        ./general/bash.nix
        ./general/catppuccin.nix
        ./general/firefox.nix
        ./general/git.nix
        ./general/nixGLOpt.nix
        ./general/ranger.nix
        ./general/starship.nix
        ./hyprDE/hypr/hyprland.nix
        ./hyprDE/kitty.nix
        ./hyprDE/rofi/rofi.nix
        ./hyprDE/waybar/waybar.nix
        ./hyprDE/wlogout/wlogout.nix
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
            starship-home.enable = lib.mkDefault true;
            catppuccin-home.enable = lib.mkDefault true;
            firefox-home.enable = lib.mkDefault true;
            ranger-home.enable = lib.mkDefault true;
            nixGLPrefix = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ";
        }

        ( lib.mkIf config.hyprDE.enable {
          # hyprland-home.enable = lib.mkDefault true;
            kitty-home.enable = lib.mkDefault true;
            rofi-home.enable = lib.mkDefault true;
            waybar-home.enable = lib.mkDefault true;
            wlogout-home.enable = lib.mkDefault true;
        })

        ( lib.mkIf config.xfceDE.enable {
            xfconf-home.enable = lib.mkDefault true;
        })
    ];
}
