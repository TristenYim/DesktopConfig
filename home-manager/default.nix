# This imports all other Home Manager modules and defines groups of default modules to enable.

{ config, pkgs, lib, ... }: 

{
    imports = [
        ./desktop-apps.nix
        ./desktop-binds.nix
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
        ./terminal/nix-search-tv.nix
        ./terminal/optnix.nix
        ./terminal/ranger.nix
        ./terminal/starship.nix
        ./terminal/television.nix
        ./terminal/zsh.nix
        ./nixvim/nixvim.nix
        ./rofi/rofi.nix
        ./theme/catppuccin.nix
        ./theme/cursor.nix
        ./theme/font.nix
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

        # This config will not build unless all default apps are set.
        # This was done intentionally to ensure all integrations and
        # keybinds work properly.
        desktop.defaultApps = {
            appLauncher = lib.mkPackageOption pkgs "default app launcher" { default = null; };
            browser = lib.mkPackageOption pkgs "default browser" { default = null; };
            fileManager = lib.mkPackageOption pkgs "default file manager" { default = null; };
            terminalEmulator = lib.mkPackageOption pkgs "default terminal emulator" { default = null; };
        };
    };

    config = lib.mkMerge 
    [
        # These should be enabled by default regardless of the use case
        {
            apeiron = {
                desktop = {
                    applications = {
                        cider.enable = lib.mkDefault true;
                        mousepad.enable = lib.mkDefault true;
                        mpv.enable = lib.mkDefault true;
                        obs.enable = lib.mkDefault true;
                        signal.enable = lib.mkDefault true;
                        qalculate.enable = lib.mkDefault true;
                        thunderbird.enable = lib.mkDefault true;
                    };

                    browsers = {
                        chromium.enable = lib.mkDefault true;
                        firefox.enable = lib.mkDefault true;
                    };

                    theme = {
                        colorscheme.catppuccin.enable = lib.mkDefault true;
                        cursor.enable = lib.mkDefault true;
                        gtk.enable = lib.mkDefault true;
                        qt.enable = lib.mkDefault true;
                    };

                    utilities = {
                        fileRoller.enable = lib.mkDefault true;
                        mime.enable = lib.mkDefault true;
                    };
                };

                terminal = {
                    alias.enable = lib.mkDefault true;
                    cryfs.enable = lib.mkDefault true;
                    git.enable = lib.mkDefault true;
                    nixvim.enable = lib.mkDefault true;
                    optnix.enable = lib.mkDefault true;
                    ranger.enable = lib.mkDefault true;
                    starship.enable = lib.mkDefault true;
                    wlclip.enable = lib.mkDefault true;

                    shells = {
                        bash.enable = lib.mkDefault true;
                        zsh.enable = lib.mkDefault true;
                    };

                    television = {
                        enable = true;
                        nix-search-tv.enable = true;
                    };
                };

                isStandalone = lib.mkDefault true;
            };
        }

        # These are modules which should be enabled on school accounts
        ( lib.mkIf config.apeiron.forSchool.enable {
            apeiron = {
                work = {
                    anki.enable = lib.mkDefault true;
                    octave.enable = lib.mkDefault true;
                    wps.enable = lib.mkDefault true;
                    zoom.enable = lib.mkDefault true;
                };
            };
        })

        # These are modules which should be enabled on machines I use for robotics
        ( lib.mkIf config.apeiron.forRobotics.enable {
            apeiron = {
                work = {
                    prusaSlicer.enable = lib.mkDefault true;
                    slack.enable = lib.mkDefault true;
                };
            };
        })

        # These modules are used in my DE
        ( lib.mkIf config.apeiron.hyprDE.enable {
            apeiron = {
                desktop = {
                    defaultApps = {
                        appLauncher = pkgs.writeShellScriptBin "rofi-hyprDE" "${lib.getExe config.programs.rofi.package} -theme $HOME/.config/rofi/run.rasi -show drun -run-command \"uwsm app -- {cmd}\"";
                        browser = config.programs.firefox.package;
                        fileManager = pkgs.xfce.thunar;
                        terminalEmulator = config.programs.kitty.package;
                    };

                    hyprland = {
                        enable = lib.mkDefault true;
                        binds.default = lib.mkDefault true;
                        plugins = {
                            hyprspace.enable = lib.mkDefault true;
                            hyprsplit.enable = lib.mkDefault true;
                        };
                    };

                    theme.fonts = {
                        enable = true;
                        merienda.enable = true;
                    };

                    utilities = {
                        feh.enable = lib.mkDefault true;
                        rofi.enable = lib.mkDefault true;
                        screenshot.enable = lib.mkDefault true;
                        swaylock.enable = lib.mkDefault true;
                        waybar.enable = lib.mkDefault true;
                        wlogout.enable = lib.mkDefault true;
                    };
                };

                services = {
                    hypridle.enable = lib.mkDefault true;
                    mako.enable = lib.mkDefault true;
                    playerctld.enable = lib.mkDefault true;
                    polkit-agent.enable = lib.mkDefault true;
                };

                terminal.emulators.kitty.enable = lib.mkDefault true;
            };
        })

        # These modules are used for XFCE profiles
        ( lib.mkIf config.apeiron.xfce.enable {
            apeiron.desktop = {
                defaultApps = {
                    appLauncher = pkgs.xfce.xfce4-appfinder;
                    browser = config.programs.firefox.package;
                    fileManager = pkgs.xfce.thunar;
                    terminalEmulator = pkgs.xfce.xfce4-terminal;
                };

                xfce.xfconf.enable = lib.mkDefault true;
            };
        })
    ];
}
