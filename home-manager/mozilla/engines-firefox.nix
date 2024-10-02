{ config, pkgs, lib, ... }: {

    config = lib.mkIf config.firefox-home.enable 
    {
        programs.firefox.profiles.user.search = {
            force = true;
            default = "Brave";
            engines = {
                "Brave" = {
                    urls = [
                        {
                            template = "https://search.brave.com/search?q={searchTerms}";
                        }

                        # This module enables address bar suggestions
                        {
                            template = "https://search.brave.com/api/suggest?q={searchTerms}";
                            type = "application/x-suggestions+json";
                        }
                    ];
                };

                # These are search tools for specific purposes

                # Use them by typing their alias and then your query
                # For example, "@nf nixos" would search for the NixOS
                # glyph from NerdFonts

                # This searchs for Nix Packages, similar to pacman -Ss
                "Nix Packages" = {
                    urls = [{
                        template = "https://search.nixos.org/packages";
                        params = [
                            {
                                name = "type";
                                value = "packages";
                            }
                            {
                                name = "query";
                                value = "{searchTerms}";
                            }
                        ];
                    }];

                    definedAliases = [ "@np" ];
                };

                # This is the standard Marriam-Webster dictionary
                "Merriam-Webster" = {
                    urls = [{
                        template = "https://www.merriam-webster.com/dictionary/{searchTerms}";
                    }];

                    definedAliases = [ "@mw" ];
                };

                # This translates a word from English to Español
                "WR English to Español" = {
                    urls = [{
                        template = "https://www.wordreference.com/enes/{searchTerms}";
                    }];

                    definedAliases = [ "@enes" ];
                };

                # This translates a word from Español to English
                "WR Español to English" = {
                    urls = [{
                        template = "https://www.wordreference.com/esen/{searchTerms}";
                    }];

                    definedAliases = [ "@esen" ];
                };

                # This searches for a icon from NerdFonts
                "Nerd Fonts" = {
                    urls = [{
                        template = "https://www.nerdfonts.com/cheat-sheet?q={searchTerms}";
                    }];

                    definedAliases = [ "@nf" ];
                };
            };
        };
    };
}
