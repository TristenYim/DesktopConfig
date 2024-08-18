{ config, pkgs, lib, ... }: {

    # Set a toggle to enable zsh config
    options = {
        zsh-home.enable = lib.mkEnableOption "Enables zsh configuration";
    };
 
    config = lib.mkIf config.bash-home.enable 
    {
        programs.zsh = {
            enable = true;
            autosuggestion = {
                enable = true;
                highlight = "fg=#ff00ff,bg=#00ff00,bold,underline";
            };
            dotDir = ".config/zsh";
            sessionVariables = {
                LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                EDITOR = "nvim";
            };
        };
    };
}
