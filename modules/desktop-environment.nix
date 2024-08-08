{ config, pkgs, lib, ... }: {
    options = {
        catppuccin-local.enable = lib.mkEnableOption "Enables Catppuccin";
        feh.enable = lib.mkEnableOption "Enables feh";
        hyprland.enable = lib.mkEnableOption "Enables Hyprland";
        mako.enable = lib.mkEnableOption "Enables mako";
        mpv.enable = lib.mkEnableOption "Enables mpv";
        nerdfonts.enable = lib.mkEnableOption "Enables Nerd Fonts";
        thunar.enable = lib.mkEnableOption "Enables Thunar";
        xfce.enable = lib.mkEnableOption "Enables Xfce";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            feh.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            mako.enable = lib.mkDefault true;
            mousepad.enable = lib.mkDefault true;
            mpv.enable = lib.mkDefault true;
          # nerdfonts.enable = lib.mkDefault true; # TODO: Figure out how to make NerdFonts build
            thunar.enable = lib.mkDefault true;
        }

        # Catpuccin
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
        ( lib.mkIf config.mpv.enable {
            fonts.packages = [
                pkgs.nerdfonts
            ];
        })

        # Thunar
        ( lib.mkIf config.thunar.enable {
          # programs.thunar = {
          #     enable = true;
          #     plugins = [
          #         pkgs.xfce.thunar-archive-plugin
          #     ];
          # };
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
