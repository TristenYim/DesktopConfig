# Environment Variables NVIDIA Specific

# See the wiki for more info as some work is required
# https://wiki.hyprland.org/hyprland-wiki/pages/Nvidia/

{ config, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings = {
            cursor = {
                no_hardware_cursors = true;
            };
            env = [ 
                # Hardware acceleration on NVIDIA GPUs
                # See Archwiki Hardware Acecleration Page for details and necessary values before setting this variable.
                # https://wiki.archlinux.org/title/Hardware_video_acceleration
                "LIBVA_DRIVER_NAME,nvidia"

                # The lines below may cause issues, proceed at your own risk

                # To force GBM as a backend, set the following environment variables:
                # See Archwiki Wayland Page for more details on those variables.
                # https://wiki.archlinux.org/title/Wayland#Requirements
                "GBM_BACKEND,nvidia-drm"
                "__GLX_VENDOR_LIBRARY_NAME,nvidia"

                # use legacy DRM interface instead of atomic mode setting. Might fix flickering issues.
                # "WLR_DRM_NO_ATOMIC,1"
                
                "NVD_BACKEND,direct"
            ];
        };
    };
}
