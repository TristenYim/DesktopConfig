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

        # Required to build
        networkmanager.enable = false;
    };

    # VM Guest tools
    services = {
        spice-vdagentd.enable = true;
        qemuGuest.enable = true;
    };

    powerManagement.cpuFreqGovernor = "performance"; # We want maximum performance

    # Enable custom modules
    hyprDE.enable = true;

    # Disable stuff not needed for the ISO build
    flatpak.enable = false;
    nixos-cli.enable = false;
    users-fathom.enable = false;
    sddm.enable = false;

    environment.defaultPackages = [
        pkgs.gparted
    ];

    system.stateVersion = lib.trivial.release;
}
