# This enables creating virtual machines
{ config, pkgs, lib, ... }: {
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
            };

            # Allows hotplugging of USB peripherals
            spiceUSBRedirection.enable = true;
        };

        # Required modules for vGPU passthrough
        boot = {
            kernelModules = [
                "vfio_pci"
                # "vfio_iommu_type1"
                # "vfio"

                # Need to be loaded early, otherwise the framebuffer output will freeze
                # See https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#initramfs for more
                # "nvidia"
                # "nvidia_modeset"
                # "nvidia_uvm"
                # "nvidia_drm"
            ];

            kernelParams = [
                "intel_iommu=on"
                "iommu=pt"
                # "vfio-pci.ids=10de:1c82,10de:0fb9"
            ];
        };

        systemd.services.libvirtd = {
            path =
            let
                env = pkgs.buildEnv {
                    name = "qemu-hook-env";
                    paths = with pkgs; [
                        bash
                        libvirt
                        kmod
                        systemd
                        ripgrep
                        sd
                    ];
                };
            in
            [env];
        };

        # Enable virt-manager, a GUI virtual machine manager
        programs.virt-manager.enable = true;

        # Adds support for useful features such as dynamic VM resizing and clipboard sharing 
        services.spice-vdagentd.enable = true;

        # Extra packages for Windows VMs
        environment.systemPackages = with pkgs; [
            virtio-win
            win-spice
        ];

        # Add users to the libvirtd group to allow them to create VMs
        users.users."fathom".extraGroups = [ "libvirtd" ];
        # users.users."tdoggy".extraGroups = if config.users-tdoggy.enable then [ "libvirtd" ] else [];
    });
}
