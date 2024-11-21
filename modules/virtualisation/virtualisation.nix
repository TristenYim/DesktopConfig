# This enables creating virtual machines
{ config, pkgs, lib, ... }: {
    imports = [
        ./passthrough.nix
    ];

    options = {
        virtualisation.enable = lib.mkEnableOption "Enables the creation of virtual machines";
    };

    config = ( lib.mkIf config.virtualisation.enable {

        # Libvirt is the virtualisation library
        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    swtpm.enable = true; # TPM, required for Windows VMs

                    # Secure boot, required for Windows VMs
                    ovmf = {
                        enable = true;
                        packages = [ pkgs.OVMFFull.fd ];
                    };
                };
                hooks.qemu.custom = ./qemu.sh;
            };

            # Allows hotplugging of USB peripherals
            spiceUSBRedirection.enable = true;
        };

        # Enable virt-manager, a GUI virtual machine manager
        programs.virt-manager.enable = true;

        # Adds support for useful features such as dynamic VM resizing and clipboard sharing 
        services.spice-vdagentd.enable = true;

        # Extra packages for Windows VMs
        environment.systemPackages = with pkgs; [
            virtio-win
            win-spice
            virtiofsd
        ];

        # Add users to the libvirtd group to allow them to create VMs
        users.users."fathom".extraGroups = [ "libvirtd" ];
        users.users."tdoggy".extraGroups = [ "libvirtd" ];
    });
}
