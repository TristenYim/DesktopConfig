{ config, pkgs, lib, ... }: {

    # Set a toggle to enable zsh config
    options = {
        zsh-home.enable = lib.mkEnableOption "Enables zsh configuration";
    };
 
    config = lib.mkIf config.zsh-home.enable 
    {
        programs = {
            zsh = {
                enable = true;
                autosuggestion = {
                    enable = true;
                    strategy = [ "completion" "history" ];
                };
                dotDir = ".config/zsh";
                history = {
                    path = "$HOME/.command_history";
                };
                sessionVariables = {
                    LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                    EDITOR = "nvim";
                };
            };
            kitty.settings.shell = "$HOME/.nix-profile/bin/zsh";
        };
    };
}
