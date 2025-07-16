{ config, pkgs, lib, myLib, ... }: 

{
    imports = with pkgs; [
        ( myLib.nixos.mkPersistenceModule [ "/var/lib/flatpak" ] [ ] [ "flatpak" ] )
        ( myLib.nixos.mkPersistenceModule [ { directory = "/var/lib/syncthing"; user = "syncthing"; group = "syncthing"; mode = "700"; } ] [ ] [ "syncthing" ] )
        ( myLib.nixos.mkPersistenceModule [ "/etc/NetworkManager/system-connections" ] [ ] [ "wifi" ] )
    ]
    ++ myLib.mapCalls (myLib.nixos.mkPkgModule)
    [
        [ btop [ "btop" ] ] # Btop++, added to ensure a system monitor exists without Home Manager
        [ cryptsetup [ "cryptsetup" ] ] # Cryptsetup, used to create dm-crypt/LUKS devices
        [ fd [ "fd" ] ] # fd, faster alternative to find
        [ killall [ "killall" ] ] # Killall, does what you'd expect
        [ ranger [ "ranger" ] ] # Ranger, added to ensure a TUI file manager exists even without Home Manager
        [ vim [ "vim" ] ] # vim, added to ensure a decent text editor exists even without Home Manager
    ];

    options.apeiron = {
        flatpak.enable = lib.mkEnableOption "flatpak";
        fwupd.enable = lib.mkEnableOption "fwupd";
        openrgb.enable = lib.mkEnableOption "openrgb";
        pipewire.enable = lib.mkEnableOption "PipeWire";
        sddm.enable = lib.mkEnableOption "SDDM";
        syncthing.enable = lib.mkEnableOption "syncthing";
        wifi.enable = lib.mkEnableOption "wifi";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            environment = {
                pathsToLink = [
                    "/share/zsh"
                ];

                systemPackages = [
                    pkgs.unchartedScripts
                ];
            };
        }

        # Flatpak, alternative package installer
        ( lib.mkIf config.apeiron.flatpak.enable {
            services.flatpak.enable = true;
            xdg.portal = {            
                enable = true;
                extraPortals = [ 
                    pkgs.xdg-desktop-portal-gtk 
                    pkgs.kdePackages.xdg-desktop-portal-kde 
                ];
                config.common.default = "gtk";
            };
        })

        # fwupd, daemon for installing firmware updates in the OS
        ( lib.mkIf config.apeiron.fwupd.enable {
            services.fwupd.enable = true;
        })

        # openrgb, allows controlling connected RGB devices
        ( lib.mkIf config.apeiron.openrgb.enable {
            services.hardware.openrgb.enable = true;
        })

        # PipeWire, the better sound server and more
        ( lib.mkIf config.apeiron.pipewire.enable {
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

        # SDDM, display (login) manager
        ( lib.mkIf config.apeiron.sddm.enable {
            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                };
            };
        })

        # Syncthing, self-hosted file synchronization platform
        ( lib.mkIf config.apeiron.syncthing.enable {
            services.syncthing = {
                enable = true;
            };
        })
    ];
}
