{ config, pkgs, lib, ... }: {
    options = {
        catppuccin-local.enable = lib.mkEnableOption "Enables Catppuccin";
        feh.enable = lib.mkEnableOption "Enables feh";
        hyprland.enable = lib.mkEnableOption "Enables Hyprland";
        hyprde.enable = lib.mkEnableOption "Enables a custom \"desktop environment\" based on Hyprland";
        mako.enable = lib.mkEnableOption "Enables mako";
        mpv.enable = lib.mkEnableOption "Enables mpv";
        nerdfonts.enable = lib.mkEnableOption "Enables Nerd Fonts";
        thunar.enable = lib.mkEnableOption "Enables Thunar";
        xfce.enable = lib.mkEnableOption "Enables Xfce";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # Catppuccin
        ( lib.mkIf config.catppuccin-local.enable {
            catppuccin = {
                enable = true;
                accent = "teal";
                flavor = "mocha";
            };
        })

        # feh
        ( lib.mkIf config.feh.enable {
            environment.systemPackages = [
                pkgs.feh
            ];
        })

        # HyprDE
        ( lib.mkIf config.hyprde.enable {
            catppuccin-local.enable = true;
            feh.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            mako.enable = lib.mkDefault true;
            mousepad.enable = lib.mkDefault true;
            mpv.enable = lib.mkDefault true;
            nerdfonts.enable = lib.mkDefault true;
            thunar.enable = lib.mkDefault true;
        })

        # Hyprland
        ( lib.mkIf config.hyprland.enable {
            programs.hyprland.enable = true;
        })

        # mako
        ( lib.mkIf config.mako.enable {
            environment.systemPackages = [
                pkgs.mako
            ];
        })

        # mpv
        ( lib.mkIf config.mpv.enable {
            environment.systemPackages = [
                pkgs.mpv
            ];
        })

        # Nerd Fonts
        ( lib.mkIf config.nerdfonts.enable {
            fonts.packages = [
                pkgs.nerdfonts
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
    ];
}
