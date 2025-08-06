# Configures wallpaper management daemon and automatic
# wallpaper loading.

{ config, lib, ... }: {
    options.apeiron.desktop.theme = {
        wallpaper.enable = lib.mkEnableOption "wallpaper management";
    };
 
    config = lib.mkIf config.apeiron.desktop.theme.wallpaper.enable 
    {
        services.swww.enable = true;

        wayland.windowManager.mango.configAttrs.exec-once = [ "${lib.getExe' config.services.swww.package "swww-daemon"}" "${lib.getExe config.services.swww.package} img ${config.home.sessionVariables.FLAKE}/source/home-manager/theme/mango1.png" ];
    };
}
