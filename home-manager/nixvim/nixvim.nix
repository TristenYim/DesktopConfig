{ config, pkgs, lib, ... }: {

    imports = [
        ./plugins.nix
    ];

    # Set a toggle to enable NixVim
    # By default, this is disabled
    options = {
        nixvim-home.enable = lib.mkEnableOption "Enables NixVim with Home Manager";
    };

    config = lib.mkIf config.nixvim-home.enable 
    {
        programs.nixvim = {
            enable = true;
            keymaps = [
                # Equivalent to nnoremap ; :
                {
                    key = ";";
                    action = ":";
                }

                # Equivalent to nmap <silent> <buffer> <leader>gg <cmd>Man<CR>
                {
                    key = "<leader>gg";
                    action = "<cmd>Man<CR>";
                    options = {
                        silent = true;
                        remap = false;
                    };
                }

                # Switch to the file browser, nvim-tree. See plugins.nvim-tree for more info on nvim-tree
                {
                    key = "fb";
                    action = "<cmd>NvimTreeFocus<CR>";
                }
            ];

            # We can set the leader key:
            globals.mapleader = ",";

            # We can create maps for every mode!
            # There is .normal, .insert, .visual, .operator, etc!

            # We can also set options:
            opts = {
                tabstop = 4; # Number of spaces a tab represents
                shiftwidth = 4; # Number of spaces used for each step of auto indentation
                expandtab = true; # Insert a tab as spaces instead of the tab character
                mouse = "a";

                cursorline = true;
                number = true;
                spell = true; # Enable spell checking
                spelllang = "en_us,es"; # Allows checking of English and Spanish words
            };

            # Of course, we can still use comfy vimscript:
            # extraConfigVim = builtins.readFile ./init.vim;
            # Or lua!
            # extraConfigLua = builtins.readFile ./init.lua;

            # There is a separate namespace for colorschemes:
            colorschemes.catppuccin = {

                # See https://nix-community.github.io/nixvim/colorschemes/catppuccin for more

                enable = true;
                settings = {
                    flavour = "mocha";
                };
            };
        };
    };
}
