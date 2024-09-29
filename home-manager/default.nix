# This imports all other Home Manager modules and defines groups of default modules to enable.

{ config, pkgs, lib, ... }: 

{
    imports = [
        ./desktop-apps.nix
        ./image-utils.nix
        ./services.nix
        ./xfce.nix
        ./hypr/hyprland.nix
        ./mozilla/firefox.nix
        ./mozilla/thunderbird.nix
        ./terminal/alias.nix
        ./terminal/bash.nix
        ./terminal/git.nix
        ./terminal/kitty.nix
        ./terminal/ranger.nix
        ./terminal/starship.nix
        ./terminal/zsh.nix
        ./nixGL/nixGLOpt.nix
        ./nixvim/nixvim.nix
        ./rofi/rofi.nix
        ./swaylock/swaylock.nix
        ./theme/catppuccin.nix
        ./theme/cursor.nix
        ./theme/gtk.nix
        ./theme/qt.nix
        ./waybar/waybar.nix
        ./wlogout/wlogout.nix
    ];
    
    options = {
        forRobotics-home.enable = lib.mkEnableOption "Enables common apps I use for robotics";
        forSchool-home.enable = lib.mkEnableOption "Enables common apps I use for school";
        hyprDE-home.enable = lib.mkEnableOption "Enables my custom Hyprland desktop environment";
        xfce-home.enable = lib.mkEnableOption "Enables XFCE";
    };

    # DE-independent defaults
    config = lib.mkMerge 
    [
        # These are modules which should be enabled by default regardless of the use case
        {
            alias-home.enable = lib.mkDefault true;
            bash-home.enable = lib.mkDefault true;
            catppuccin-home.enable = lib.mkDefault true;
            chromium-home.enable = lib.mkDefault true;
            cider-home.enable = lib.mkDefault true;
            cryfs-home.enable = lib.mkDefault true;
            cursor-home.enable = lib.mkDefault true;
            firefox-home.enable = lib.mkDefault true;
            gtk-home.enable = lib.mkDefault true;
            mousepad-home.enable = lib.mkDefault true;
            mpv-home.enable = lib.mkDefault true;
            neofetch-home.enable = lib.mkDefault true;
            nixvim-home.enable = lib.mkDefault true;
            obs-home.enable = lib.mkDefault true;
            qalculate-home.enable = lib.mkDefault true;
            qt-home.enable = lib.mkDefault true;
            ranger-home.enable = lib.mkDefault true;
            starship-home.enable = lib.mkDefault true;
            thunderbird-home.enable = lib.mkDefault true;
            # zsh-home.enable = lib.mkDefault true;
            nixGLPrefix = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";
        }

        # These are modules which should be enabled on school accounts
        ( lib.mkIf config.forSchool-home.enable {
            anki-home.enable = lib.mkDefault true;
            libreOffice-home.enable = lib.mkDefault true;
            zoom-home.enable = lib.mkDefault true;
        })

        # These are modules which should be enabled on machines I use for robotics
        ( lib.mkIf config.forRobotics-home.enable {
            prusaSlicer-home.enable = lib.mkDefault true;
            slack-home.enable = lib.mkDefault true;
        })

        # These modules are used in my DE
        ( lib.mkIf config.hyprDE-home.enable {
            copyq-home.enable = lib.mkDefault true;
            feh-home.enable = lib.mkDefault true;
            file-roller-home.enable = lib.mkDefault true;
            hycov-home.enable = lib.mkDefault true;
            hyprland-home.enable = lib.mkDefault true;
            hypridle-home.enable = lib.mkDefault true;
            kitty-home.enable = lib.mkDefault true;
            mako-home.enable = lib.mkDefault true;
            playerctld-home.enable = lib.mkDefault true;
            polkit-agent-home.enable = lib.mkDefault true;
            rofi-home.enable = lib.mkDefault true;
            screenshot-home.enable = lib.mkDefault true;
            swaylock-home.enable = lib.mkDefault true;
            waybar-home.enable = lib.mkDefault true;
            wlogout-home.enable = lib.mkDefault true;
        })

        # These modules are used in my fallback DE
        ( lib.mkIf config.xfce-home.enable {
            xfconf-home.enable = lib.mkDefault true;
        })
    ];
}
