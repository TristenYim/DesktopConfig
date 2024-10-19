{ config, pkgs, lib, ... }: {

    config = lib.mkIf config.nixvim-home.enable 
    {
        # One of the big advantages of NixVim is how it provides modules for
        # popular vim plugins
        # Enabling a plugin this way skips all the boring configuration that
        # some plugins tend to require.
        programs.nixvim.plugins = {
            comment = {
                # Comment is a plugin that adds a keybind to comment lines.

                # See https://github.com/numToStr/Comment.nvim for more
                # Or https://nix-community.github.io/nixvim/plugins/comment
                # for NixVim specific documentation (Note: Look in the "settings" tab)
            };

            cmp = {
                # nvim-cmp is a code auto-completion plugin.

                # See https://github.com/hrsh7th/nvim-cmp for more
                # Or https://nix-community.github.io/nixvim/plugins/cmp
                # for NixVim specific documentation

                enable = true;

                settings = {
                    mapping = {
                        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})"; 
                    };
                    sources = [
                        { name = "nvim_lsp"; }
                        { name = "path"; }
                        { name = "buffer"; }
                    ];
                };
            };

            lightline = {
                # Lightline is enabled in the example NixVim config

                # See https://github.com/itchyny/lightline.vim for more
                # Or https://nix-community.github.io/nixvim/plugins/lightline
                # for NixVim specific documentation

                enable = true;

                # This is one of lightline's example configurations
                settings = {
                    active = {
                        left = [
                            [
                                "mode"
                                "paste"
                            ]
                            [
                                "readonly"
                                "filename"
                                "modified"
                                "poweredbynix"
                            ]
                        ];
                    };
                    colorscheme = "ayu_mirage";
                    component = {
                        poweredbynix = "󱄅  Powered by Nix!";
                    };
                };
            };

            lsp = {
                # Lsp is required for features such as autocompletion and linting

                # Why? I don't know, the neovim community is terrible at explaining how things work.
                # The words that are used when explaining what things do (such as "fuzzy finding") are
                # never explained, rendering any explanations derived from them useless.

                enable = true;
                
                # These are the languages to support.
                servers = {
                    bashls.enable = true;
                    cssls.enable = true;

                    # markdown_oxide.enable = true;
                    # matlab_ls.enable = true;
                    nixd.enable = true;
                };
            };

            neoscroll = {
                # Makes scrolling look better

                # See https://github.com/karb94/neoscroll.nvim for more
                # Or https://nix-community.github.io/nixvim/plugins/neoscroll
                # for NixVim specific documentation (Note: Look in the "settings" tab)

                enable = true;
            };

            nvim-tree = {
                # nvim-tree is a simple tree view file manager sidebar plugin for Neovim
                # nvim-tree has a similar layout to the VSCode file manager and ranger

                # See https://github.com/nvim-tree/nvim-tree.lua for more
                # Or https://nix-community.github.io/nixvim/plugins/nvim-tree
                # for NixVim specific documentation

                enable = true;
                hijackCursor = true; # Sets the cursor to the beginning of the line when browsing
                openOnSetup = true; # Automatically open nvim-tree when Neovim is launched
            };

            treesitter = {
                # Tree-sitter is a parser generator tool for recognizing language syntax.

                # See https://github.com/nvim-treesitter/nvim-treesitter for more
                # Or https://nix-community.github.io/nixvim/plugins/treesitter
                # for NixVim specific documentation

                enable = true;
                settings = {
                    highlight.enable = true;
                };
            };

            # Of course, there are a lot more plugins available.
            # You can find an up-to-date list here:
            # https://nixvim.pta2002.com/plugins
        };

        # What about plugins not available as a module?
        # Use extraPlugins:
        programs.nixvim.extraPlugins = with pkgs.vimPlugins; [ vim-toml ];
    };
}
