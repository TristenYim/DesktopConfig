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

    powerManagement.cpuFreqGovernor = "performance"; # We want maximum performance

    services = {
        displayManager.autoLogin = {
            enable = true;
            user = "nixos";
        };

        # VM Guest tools
        spice-vdagentd.enable = true;
        qemuGuest.enable = true;
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
    hyprDE.enable = true;

    # Disable stuff not needed for the ISO build
    flatpak.enable = false;
    nixos-cli.enable = false;
    users-fathom.enable = false;

    # DO NOT ENABLE ENVFS IT WILL SCREW UP EVERYTHING
    envfs.enable = false;

    environment.defaultPackages = [
        pkgs.gparted
    ];

    isoImage.edition = lib.mkForce "shallow";

    system.stateVersion = lib.trivial.release;
}
