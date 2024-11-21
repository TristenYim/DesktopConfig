{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        btop.enable = lib.mkEnableOption "Enables BTOP++";
        cryptsetup.enable = lib.mkEnableOption "Enables cryptsetup";
        envfs.enable = lib.mkEnableOption "Enables envfs";
        flatpak.enable = lib.mkEnableOption "Enables flatpak";
        killall.enable = lib.mkEnableOption "Enables killall";
        nixos-cli.enable = lib.mkEnableOption "Enables nixos-cli";
        pulse.enable = lib.mkEnableOption "Enables PulseAudio";
        pipewire.enable = lib.mkEnableOption "Enables PipeWire";
        ranger.enable = lib.mkEnableOption "Enables ranger";
        sddm.enable = lib.mkEnableOption "Enables SDDM";
        vim.enable = lib.mkEnableOption "Enables vim";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            environment.pathsToLink = [
                "/share/zsh"
            ];
        }

        # Btop++, added to ensure a system monitor exists without Home Manager
        ( myLib.nixos.enablePkgSameOptName "btop" )

        # Cryptsetup, used to create dm-crypt/LUKS devices
        ( myLib.nixos.enablePkgSameOptName "cryptsetup" )

        # Envfs, restores some FHS compliance
        ( lib.mkIf config.envfs.enable {
            services.envfs.enable = true;
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

        # Killall, which does what you'd expect
        ( myLib.nixos.enablePkgSameOptName "killall" )

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
                pkgs.pamixer
            ];
        })

        # PipeWire, the better sound server and more
        ( lib.mkIf config.pipewire.enable {
            services.pipewire = {
                enable = true;
                pulse.enable = true;
                alsa = {
                    enable = true;
                    support32Bit = true;
                };
            };

            environment.systemPackages = [
                pkgs.pavucontrol
                pkgs.pamixer
            ];
        })

        # Ranger, added to ensure a decent TUI file manager exists without Home Manager
        ( myLib.nixos.enablePkgSameOptName "ranger" )

        # SDDM, display (login) manager
        ( lib.mkIf config.sddm.enable {
            environment.systemPackages = [ pkgs.libsForQt5.sddm ];

            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                     catppuccin.assertQt6Sddm = false;
                };
            };
        })

        # vim, added to ensure a decent text editor exists even without Home Manager
        ( myLib.nixos.enablePkgSameOptName "vim" )
    ];
}
