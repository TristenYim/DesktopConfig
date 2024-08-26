# Declares persistent files and directories
# These are NOT erased on reboot in the impermanence setup
{ config, pkgs, ... }: {
    environment.persistence."/pers" = {
        hideMounts = true;
        directories = [
            "/etc/nixos" # NixOS configuration files
            "/var/lib/nixos" # Important NixOS cache

            "/var/log" # System log directory
            "/var/lib/systemd/coredump" # Systemd coredump logs

            "/var/lib/libvirt/images/persistent" # Virtual machine filesystems
            "/var/lib/libvirt/qemu" # Virtual machine configurations

            "/var/lib/flatpak" # Flatpak things
        ];
        files = [
            # Put your files here
        ];
    };
}
