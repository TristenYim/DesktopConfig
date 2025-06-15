# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ modulesPath, lib, pkgs, ... }:

{
    imports =
    [
        ./../../modules
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ];

    console.useXkbConfig = true; # Prevents systemd-vconsole-setup.service from failing on boot

    networking = {
        hostName = "shallow-ISO"; # Define your hostname

        wireless.enable = false; # I prefer NetworkManager over wpa_supplicant
    };

    powerManagement.cpuFreqGovernor = "performance"; # We want maximum performance

    services = {
        displayManager.autoLogin = {
            enable = true;
            user = "nixos";
        };

        # VM Guest tools
        spice-vdagentd.enable = true;
        qemuGuest.enable = true;

        # More relevant help message
        getty.helpLine = ''
            Welcome to shallow-ISO, a Hyprland installation ISO!

            To log in over ssh you must set a password for either "nixos" or "root"
            with `passwd` (prefix with `sudo` for "root"), or add your public key to
            /home/nixos/.ssh/authorized_keys or /root/.ssh/authorized_keys.

            If you need a wireless connection, type `nmtui`.

            To install, mount your partitions and run nixos-install.
        '';
    };

    # Prevents polkit from asking for the password.
    # Since the ISO user doesn't have a password anyway,
    # there's no reason to ask for it.
    security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (subject.isInGroup("wheel")) {
                return polkit.Result.YES;
            }
        });
    '';

    # Enable custom modules
    apeiron = {
        hyprDE.enable = true;

        # Disable stuff not needed for the ISO build
        users.fathom.enable = false;

        flatpak.enable = false;
        swaylock.enable = false;
    };

    environment.defaultPackages = [
        pkgs.gparted
    ];

    isoImage.edition = lib.mkForce "shallow";

    system.stateVersion = lib.trivial.release;
}
