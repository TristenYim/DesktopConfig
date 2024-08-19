{ config, pkgs, lib, nixos-cli, ... }: {
    options = {
        btop.enable = lib.mkEnableOption "Enables BTOP++";
        flatpak.enable = lib.mkEnableOption "Enables flatpak";
        nixos-cli.enable = lib.mkEnableOption "Enables nixos-cli";
        pulse.enable = lib.mkEnableOption "Enables PulseAudio";
        ranger.enable = lib.mkEnableOption "Enables ranger";
        sddm.enable = lib.mkEnableOption "Enables SDDM";
        vim.enable = lib.mkEnableOption "Enables vim";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            btop.enable = lib.mkDefault true;
            flatpak.enable = lib.mkDefault true;
            nixos-cli.enable = lib.mkDefault true;
            pulse.enable = lib.mkDefault true;
            ranger.enable = lib.mkDefault true;
            sddm.enable = lib.mkDefault true;
            vim.enable = lib.mkDefault true;

            environment.pathsToLink = [
                "/share/zsh"
            ];
        }

        # Btop++, task manager
        ( lib.mkIf config.btop.enable {
            environment.systemPackages = [
                pkgs.btop
            ];
        })

        # Flatpak, alternative package installer
        ( lib.mkIf config.flatpak.enable {
            services.flatpak.enable = true;
            xdg.portal = {            
                enable = true;
                extraPortals = [ 
                    pkgs.xdg-desktop-portal-gtk 
                ];
                config.common.default = "gtk";
            };
        })

        # nixos-cli, adds a better cli for NixOS operations
        ( lib.mkIf config.nixos-cli.enable {
            services.nixos-cli = {
                enable = true;
            };
        })

        # Pulseaudio, sound server
        ( lib.mkIf config.pulse.enable {
            hardware.pulseaudio = {
                enable = true;
                package = pkgs.pulseaudioFull;
                support32Bit = true;
            };
            nixpkgs.config.pulseaudio = true;

            environment.systemPackages = [
                pkgs.pavucontrol
            ];
        })

        # Ranger, TUI file manager
        ( lib.mkIf config.ranger.enable {
            environment.systemPackages = [
                pkgs.ranger
            ];
        })

        # SDDM, display (login) manager
        ( lib.mkIf config.sddm.enable {
            environment.systemPackages = [
                pkgs.libsForQt5.sddm
            ];

            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                     catppuccin.assertQt6Sddm = false;
                };
            };
        })

        # vim
        ( lib.mkIf config.vim.enable {
            environment.systemPackages = [
                pkgs.vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
            ];
        })
    ];
}
