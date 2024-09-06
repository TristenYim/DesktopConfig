{ config, pkgs, lib, inputs, ... }: {
    options = {
        hyprDE.enable = lib.mkEnableOption "Enables a custom \"desktop environment\" based on Hyprland";
        xfce.enable = lib.mkEnableOption "Enables Xfce";

        catppuccin-local.enable = lib.mkEnableOption "Enables Catppuccin";
        kitty.enable = lib.mkEnableOption "Enables kitty";
        hyprland.enable = lib.mkEnableOption "Enables Hyprland";
        nerdfonts.enable = lib.mkEnableOption "Enables Nerd Fonts";
        swaylock.enable = lib.mkEnableOption "Enables Swaylock";
        thunar.enable = lib.mkEnableOption "Enables Thunar";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [

        # I want things to look nice by default
        {
            catppuccin.enable = lib.mkDefault true;
            nerdfonts.enable = lib.mkDefault true;
        }

        # HyprDE
        ( lib.mkIf config.hyprDE.enable {
            kitty.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            swaylock.enable = lib.mkDefault true;
            thunar.enable = lib.mkDefault true;
        })

        # Xfce
        ( lib.mkIf config.xfce.enable {
            services.xserver = {
                enable = true;
                desktopManager = {
                    xterm.enable = false;
                    xfce = {
                        enable = true;
                        enableScreensaver = false;
                    };
                };
            };
            environment.xfce.excludePackages = [
                pkgs.xfce.parole 
                pkgs.xfce.ristretto 
                pkgs.xterm
            ];
            programs.thunar.plugins = with pkgs.xfce;
            [
                thunar-archive-plugin
            ];
        })

        # Catppuccin
        ( lib.mkIf config.catppuccin-local.enable {
            catppuccin = {
                enable = true;
                accent = "teal";
                flavor = "mocha";
            };
        })

        # kitty
        ( lib.mkIf config.kitty.enable {
            environment.systemPackages = [
                pkgs.kitty
            ];
        })

        # Hyprland
        ( lib.mkIf config.hyprland.enable {
            programs.hyprland = {
                enable = true;
                package = inputs.hyprland.packages."${pkgs.system}".hyprland;
            };
        })

        # Nerd Fonts
        ( lib.mkIf config.nerdfonts.enable {
            fonts.packages = [
                pkgs.nerdfonts
            ];
        })

        # Swaylock
        ( lib.mkIf config.swaylock.enable {
            environment.systemPackages = [
                pkgs.swaylock-effects
            ];
        })

        # Thunar
        ( lib.mkIf config.thunar.enable {
            programs.thunar = {
                enable = true;
                plugins = [
                    pkgs.xfce.thunar-archive-plugin
                ];
            };
        })
    ];
}
