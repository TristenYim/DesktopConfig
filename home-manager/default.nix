# This imports all other Home Manager modules and defines groups of default modules to enable.

{ config, lib, ... }: 

{
    imports = [
        ./desktop-apps.nix
        ./image-utils.nix
        ./mime.nix
        ./nixGL.nix
        ./persistence.nix
        ./services.nix
        ./swaylock.nix
        ./xfce.nix
        ./ethanol/default.nix
        ./hypr/hyprland.nix
        ./mozilla/firefox.nix
        ./mozilla/thunderbird.nix
        ./terminal/alias.nix
        ./terminal/bash.nix
        ./terminal/basic-packages.nix
        ./terminal/git.nix
        ./terminal/kitty.nix
        ./terminal/ranger.nix
        ./terminal/starship.nix
        ./terminal/zsh.nix
        ./nixvim/nixvim.nix
        ./rofi/rofi.nix
        ./theme/catppuccin.nix
        ./theme/cursor.nix
        ./theme/gtk.nix
        ./theme/qt.nix
        ./waybar/waybar.nix
        ./wlogout/wlogout.nix
        ../overlays/home.nix
    ];
    
    options.apeiron = {
        forRobotics.enable = lib.mkEnableOption "common apps I use for robotics";
        forSchool.enable = lib.mkEnableOption "common apps I use for school";
        hyprDE.enable = lib.mkEnableOption "my custom Hyprland desktop environment";
        xfce.enable = lib.mkEnableOption "XFCE";
        nvidia.enable = lib.mkEnableOption "options required when using Nvidia GPUs";
        isStandalone = lib.mkEnableOption "standalone home-manager tools";
    };

    config = lib.mkMerge 
    [
        # These should be enabled by default regardless of the use case
        {
            apeiron = {
                alias.enable = lib.mkDefault true;
                bash.enable = lib.mkDefault true;
                catppuccin.enable = lib.mkDefault true;
                chromium.enable = lib.mkDefault true;
                cider.enable = lib.mkDefault true;
                cryfs.enable = lib.mkDefault true;
                cursor.enable = lib.mkDefault true;
                firefox.enable = lib.mkDefault true;
                fileRoller.enable = lib.mkDefault true;
                git.enable = lib.mkDefault true;
                gtk.enable = lib.mkDefault true;
                mousepad.enable = lib.mkDefault true;
                mpv.enable = lib.mkDefault true;
                mime.enable = lib.mkDefault true;
                nixvim.enable = lib.mkDefault true;
                wlclip.enable = lib.mkDefault true;
                obs.enable = lib.mkDefault true;
                qalculate.enable = lib.mkDefault true;
                qt.enable = lib.mkDefault true;
                ranger.enable = lib.mkDefault true;
                starship.enable = lib.mkDefault true;
                thunderbird.enable = lib.mkDefault true;
                zsh.enable = lib.mkDefault true;

                isStandalone = lib.mkDefault true;
            };
        }

        # These are modules which should be enabled on school accounts
        ( lib.mkIf config.apeiron.forSchool.enable {
            apeiron = {
                anki.enable = lib.mkDefault true;
                octave.enable = lib.mkDefault true;
                wps.enable = lib.mkDefault true;
                zoom.enable = lib.mkDefault true;
            };
        })

        # These are modules which should be enabled on machines I use for robotics
        ( lib.mkIf config.apeiron.forRobotics.enable {
            apeiron = {
                prusaSlicer.enable = lib.mkDefault true;
                slack.enable = lib.mkDefault true;
            };
        })

        # These modules are used in my DE
        ( lib.mkIf config.apeiron.hyprDE.enable {
            apeiron = {
                # copyq.enable = lib.mkDefault true;
                feh.enable = lib.mkDefault true;
                hyprland.enable = lib.mkDefault true;
                hyprland.binds.default = lib.mkDefault true;
                hyprland.plugins.hycov.enable = lib.mkDefault true;
                hyprland.plugins.hyprspace.enable = lib.mkDefault true;
                hyprland.plugins.hyprsplit.enable = lib.mkDefault true;
                hypridle.enable = lib.mkDefault true;
                kitty.enable = lib.mkDefault true;
                mako.enable = lib.mkDefault true;
                playerctld.enable = lib.mkDefault true;
                polkit-agent.enable = lib.mkDefault true;
                rofi.enable = lib.mkDefault true;
                screenshot.enable = lib.mkDefault true;
                swaylock.enable = lib.mkDefault true;
                waybar.enable = lib.mkDefault true;
                wlogout.enable = lib.mkDefault true;
            };
        })

        # These modules are used for XFCE profiles
        ( lib.mkIf config.apeiron.xfce.enable {
            apeiron.xfconf.enable = lib.mkDefault true;
        })
    ];
}
