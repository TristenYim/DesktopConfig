{ config, lib, ... }: {
    options.apeiron.terminal = {
        shells.zsh.enable = lib.mkEnableOption "zsh configuration";
    };
 
    config = lib.mkIf config.apeiron.terminal.shells.zsh.enable 
    {
        programs = 
        let
            home = config.home.homeDirectory;
        in
        {
            zsh = {
                enable = true;

                autosuggestion = {
                    enable = true;
                    strategy = [ "completion" ];
                };

                dotDir = "${home}/.config/zsh";

                history = {
                    path = "${home}/.command_history";
                    share = false;
                };

                sessionVariables = {
                    LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                    EDITOR = "nvim";
                };

                initContent = ''
                    setopt INC_APPEND_HISTORY
                    bindkey "^[[1;5D" backward-word
                    bindkey "^[[1;5C" forward-word
                    bindkey "^H" backward-kill-word
                    bindkey "^[^?" backward-kill-word
                '';
            };

            kitty.settings.shell = "${home}/.nix-profile/bin/zsh";
        };
    };
}
